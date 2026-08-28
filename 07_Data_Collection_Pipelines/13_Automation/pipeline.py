from pathlib import Path
from datetime import datetime

log_file = Path(__file__).parent / "pipeline_log.txt"

with open(log_file, "a") as file:
    file.write(f"Pipeline executed! {datetime.now()}\n")