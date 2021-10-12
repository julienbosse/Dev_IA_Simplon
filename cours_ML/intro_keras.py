import tensorflow as tf
from tensorflow.keras.layers import Dense

model = tf.keras.Sequential()
model.add(Dense(50, activation="relu"))
model.add(Dense(2, activation="linear"))

model.compile(optimizer="sgd", loss="mse")

print(model.summary())