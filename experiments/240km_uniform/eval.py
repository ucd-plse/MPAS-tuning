import xarray as xr
import numpy as np
from glob import glob
import sys
import os
import datetime
import pandas as pd

non_float_vars_drop = [
    'indexToCellID',
    'indexToEdgeID',
    'indexToVertexID',
    'cellsOnEdge',
    'nEdgesOnCell',
    'nEdgesOnEdge',
    'edgesOnCell',
    'edgesOnEdge',
    'cellsOnCell',
    'verticesOnCell',
    'verticesOnEdge',
    'edgesOnVertex',
    'cellsOnVertex',
    'initial_time',
    'xtime',
    'iLev_DT',
    'i_rainnc',
    'i_rainc',
    'kpbl',
    'mminlu',
    'isice_lu',
    'iswater_lu'
]

log_path = sys.argv[1]
log_path_for_baseline = sys.argv[2]

cost = 0
try:
    with open(os.path.join(log_path, "stdout.txt"), "r") as f:
        for line in f.readlines():
            if line.startswith("  1 total time"):
                cost = float(line.split()[3])
except:
    pass

data = []
for file_name in sorted([x for x in glob("history.*.nc")]):

    time = datetime.datetime(*[int(x) for x in file_name[file_name.find(".") + 1: file_name.rfind(".")].replace("_", "-").replace(".", "-").split("-")])
    this_data = xr.open_dataset(file_name).drop(non_float_vars_drop)

    # save baseline output files if this is config 0000
    if log_path.endswith("prose_logs/0000"):
        os.rename(file_name, os.path.join(log_path, file_name))
        baseline_data = this_data
    else:
        baseline_data = xr.open_dataset(os.path.join(log_path_for_baseline, file_name)).drop(non_float_vars_drop)

    this_data_dict = (this_data - baseline_data).map(np.linalg.norm).to_array().to_pandas().to_dict()
    this_data_dict["time"] = time
    data.append(this_data_dict)

# save errors
pd.DataFrame(data).to_pickle(os.path.join(log_path, "errors.pckl"))

# cleanup
for file_name in glob("history.*.nc"):
    os.remove(file_name)
for file_name in glob("diag.*.nc"):
    os.remove(file_name)
for file_name in glob("restart.*.nc"):
    os.remove(file_name)    

print(cost)