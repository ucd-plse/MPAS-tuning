# %%
import pandas as pd
import numpy as np
import plotly.express as px
import plotly.graph_objects as go
import os
from glob import glob
import xarray as xr

# %%
def plot_performance_vs_correctness_L2(df, error_type):
    yaxis_tickformat = ".0e"

    log_y = True

    df_plot = df.dropna(subset=["Cost", f"{error_type}, Relative Error (L2 Norm)"])

    baseline_cost = df[(df['Configuration Number'] == 0)]['Cost'].iloc[0]
    df_plot = df_plot.assign(Improvement = baseline_cost/df_plot['Cost'])
    
    fig = px.scatter(
        df_plot,
        x = "Improvement",
        y = f"{error_type}, Relative Error (L2 Norm)",
        color = '32:64 Ratio',
        log_y = True,
    )

    fig.update_traces(
        marker={
            'size' : 8,
         #   'symbol' : "x-thin",
         #   'line_width' : 1,
            # 'line_color' : "black",
            'opacity' : 0.5,
        }
    )

    if not log_y:
        fig.add_trace(
            go.Scattergl(
                x = df_plot[df_plot["Configuration Number"] == 0]["Improvement"],
                y = df_plot[df_plot["Configuration Number"] == 0][f"{error_type}, Relative Error (L2 Norm)"],
                mode = "markers",
                marker_symbol = 'star',
                marker_size = 14,
                marker_color = "blue",
                marker_line_width = 1,
                marker_line_color = "black",
                name = "Uniform 64-bit"
            )
        )

    if not df_plot[df_plot["Configuration Number"] == 1].empty:
        fig.add_trace(
            go.Scattergl(
                x = df_plot[df_plot["Configuration Number"] == 1]["Improvement"],
                y = df_plot[df_plot["Configuration Number"] == 1][f"{error_type}, Relative Error (L2 Norm)"],
                mode = "markers",
                marker_symbol = 'star',
                marker_size = 14,
                marker_color = "white",
                marker_line_width = 1,
                marker_line_color = "black",
                name = "All 32-bit"
            )
        )

    fig.add_vline(x=1, line_width=2, line_dash="dash", line_color="grey")

    fig.update_layout(
        title_text ="MPAS",
        yaxis_tickformat = ".2e",
        xaxis_tickformat = ".1f",
        xaxis_ticksuffix = "x",
        xaxis_title = "Speedup",
        yaxis_title = "Relative Error",
    )

    return fig


def plot_label_frequency(df):

    fig = px.histogram(
        df,
        x = "Label",
    )
    fig.update_layout(
        font_size = 18
    )

    return fig


def get_MPAS_data(search_log_path):

    global LONG_NAME_MAP

    with open(search_log_path, "r") as f:
        search_log_lines = f.readlines()

    df = []
    for line in search_log_lines:
        row = {}

        try:
            row['Configuration Number'] = int(line.split(":")[0])
        except ValueError:
            continue
        config_dir_path = os.path.join(os.path.dirname(search_log_path), f"{row['Configuration Number']:0>4}")

        config_path = glob(f"{config_dir_path}/config*")
        assert ( len(config_path) == 1)
        row['Configuration Path'] = config_path[0]
 
        float_count = 0
        double_count = 0
        with open(row['Configuration Path'], "r" ) as f:
            llines = f.readlines()
            for lline in llines:
                if ",4" in lline:
                    float_count += 1
                elif ",8" in lline:
                    double_count += 1

        row['32:64 Ratio'] = float_count / (double_count + float_count)

        if "[PASSED]" in line:
            row['Label'] = "Passed"
            row['Cost'] = float(line.split()[4])
        elif "error threshold was exceeded" in line:
            row['Label'] = "Failed"
            row['Cost'] = float(line.split()[4])
        elif "(timeout)" in line:
            row['Label'] = "Timeout"
            row['Cost'] = float(line.split()[4])
        elif "(runtime failure)" in line:
            row['Label'] = "Runtime Error"
            row['Cost'] = np.nan
        elif "(compilation error)" in line:
            row['Label'] = 'Compilation Error'
            row['Cost'] = np.nan
        elif "(plugin error)" in line:
            row['Label'] = 'Prose Plugin Error'
            row['Cost'] = np.nan
        else:
            continue

        try:
            errors_df = pd.read_pickle(os.path.join(config_dir_path, "errors.pckl"))
            for column_name in errors_df.columns:
                if column_name != "time":
                    metric = LONG_NAME_MAP[column_name].long_name
                    row[f"{metric}, Relative Error (Average)"] = np.mean(errors_df[column_name])
                    row[f"{metric}, Relative Error (Variance)"] = np.var(errors_df[column_name])
                    row[f"{metric}, Relative Error (Median)"] = np.median(errors_df[column_name])
                    row[f"{metric}, Relative Error (Max)"] = np.max(errors_df[column_name])
                    row[f"{metric}, Relative Error (Min)"] = np.min(errors_df[column_name])
                    row[f"{metric}, Relative Error (75th percentile)"] = np.percentile(errors_df[column_name], 75)
                    row[f"{metric}, Relative Error (25th percentile)"] = np.percentile(errors_df[column_name], 25)
                    row[f"{metric}, Relative Error (L2 Norm)"] = np.linalg.norm(errors_df[column_name], ord=2)

        except FileNotFoundError:
            for column_name in errors_df.columns:
                if column_name != "time":
                    metric = LONG_NAME_MAP[column_name].long_name
                    row[f"{metric}, Relative Error (Average)"] = np.nan
                    row[f"{metric}, Relative Error (Variance)"] = np.nan
                    row[f"{metric}, Relative Error (Median)"] = np.nan
                    row[f"{metric}, Relative Error (Max)"] = np.nan
                    row[f"{metric}, Relative Error (Min)"] = np.nan
                    row[f"{metric}, Relative Error (75th percentile)"] = np.nan
                    row[f"{metric}, Relative Error (25th percentile)"] = np.nan
                    row[f"{metric}, Relative Error (L2 Norm)"] = np.nan

        df.append(row)

    return pd.DataFrame(df)

# %%
LONG_NAME_MAP = xr.open_dataset("./prose_logs/0000/history.2014-09-10_00.00.00.nc")
df = get_MPAS_data("./prose_logs/search_log.txt")

# %%
fig = plot_performance_vs_correctness_L2(df, error_type="Pressure")
fig.write_html("/root/precimonious-w-rose/MPAS_results.html")
