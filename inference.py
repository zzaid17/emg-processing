import numpy as np
import time
import os
from keras.models import load_model

# Load pre-trained model
model = load_model('models/cnn_tuned.keras')
file_path = 'data/live_data.csv'
buffer = []
WINDOW_SIZE = 200
STEP_SIZE = 50

print("Beginning EMG classification with BioRadio input...")

while True:
    if os.path.exists(file_path):
        try:
            # Load most recent 200-sample window
            data = np.loadtxt(file_path, delimiter=',')

            # Add new samples to buffer
            buffer.extend(data.tolist())

            # Predict on sliding windows
            while len(buffer) >= WINDOW_SIZE:
                window_data = np.array(buffer[:WINDOW_SIZE]).reshape(1, WINDOW_SIZE, 1)

                prediction = model.predict(window_data)
                label = np.argmax(prediction)

                print(f"Prediction: {label} (raw: {prediction[0]})")

                # Slide window
                buffer = buffer[STEP_SIZE:]

        except Exception as e:
            print("Error reading file:", e)

    time.sleep(0.1)
