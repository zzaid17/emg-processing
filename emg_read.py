import numpy as np
import time
import os

file_path = 'data/live_data.csv'
last_data = None

print("Watching emg_window.csv...")

while True:
    if os.path.exists(file_path):
        try:
            data = np.loadtxt(file_path)

            # Print new windows only if they are different from the last one
            if not np.array_equal(data, last_data):
                last_data = data.copy()
                print(f"New EMG window ({len(data)} samples):")
                print(data[:10], '...') # First 10 samples

        except Exception as e:
            print("Error reading file:", e)

    time.sleep(0.1)