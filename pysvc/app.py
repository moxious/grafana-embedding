from opentelemetry import trace
from opentelemetry import metrics
import time
import random

from random import randint
from flask import Flask

tracer = trace.get_tracer("diceroller.tracer")
meter = metrics.get_meter("diceroller.meter")
roll_counter = meter.create_counter(
    "dice.rolls",
    description="The number of rolls by roll value",
)

app = Flask(__name__)

@app.route("/rolldice")
def roll_dice():
    return str(roll())

def roll():
    with tracer.start_as_current_span("roll") as rollspan:

       if random.uniform(0, 1) < 0.5:
          time.sleep(random.uniform(0, 2))
       else: 
          time.sleep(random.uniform(0, 0.3))

       res = randint(1,6)
       rollspan.set_attribute("roll.value", res)
       roll_counter.add(1, {"roll.value": res})
       return randint(1, 6)

