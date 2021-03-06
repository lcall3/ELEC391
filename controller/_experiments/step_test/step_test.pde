//##########################################################################
//
// lcall3 Controller is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// lcall3 Controller is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with lcall3 Controller. If not, see <http://www.gnu.org/licenses/>.
// 
//##########################################################################

import processing.serial.*;

Serial arduino;
int receivedValue;
IntList receivedValues;

boolean overflowAngle = true;

float norm_height = 200;
float center_height;
float norm_width;

final int PULSE_PER_REV = 400;
final float DESTINATION = 360;

final int BAUD_RATE = 9600;

void setup() {
    size(800, 600);

    String[] portList = Serial.list();
    for (int i = 0; i < portList.length; i++) {
        try {
            String portName = Serial.list()[i];
            arduino = new Serial(this, portName, BAUD_RATE);
            break;
        } catch (Throwable t) {
            println(Serial.list()[i] + " is not available for Serial communication");
        }
    }

    frameRate(60);

    center_height = height / 2 + 100;
    norm_width = width - 50;

    receivedValues = new IntList();
}

void draw() {
    background(0);
    drawUI();

    if (arduino != null) {
        drawExpected();
        drawSerialResponse();
    } else {
        drawNA();
    }
}

void drawUI() {
    stroke(255);
    line(50, 0, 50, height);
    line(0, center_height, width, center_height);
    fill(255);
    text("time (s)", width - textWidth("time (s)"), center_height - 4);
    text("response (deg)", 54, 20);
}

void drawExpected() {
    stroke(255, 255, 0);
    line(50, center_height - norm_height, width, center_height - norm_height);
    fill(255, 255, 0);
    text("Expected response (" + str(DESTINATION) + ")", 54, center_height - norm_height - 4);
}

int dataPoints;
void drawSerialResponse() {
    // Draw the line
    dataPoints = receivedValues.size();
    if (dataPoints == 0) return;

    float delta_x = norm_width / dataPoints;
    strokeWeight(3);
    stroke(0, 255, 0);
    for (int i = 1; i < dataPoints; i++) {
        int sensor = receivedValues.get(i);
        float angle = sensor * 360.0 / PULSE_PER_REV;
        
        float y = map(angle, 0, DESTINATION, center_height, center_height - norm_height);
        float prev_y = map(receivedValues.get(i - 1) * 360.0 / PULSE_PER_REV, 0, DESTINATION, center_height, center_height - norm_height);
        line(50 + (i - 1) * delta_x, prev_y, 50 + i * delta_x, y);

        if (i == dataPoints - 1) {
            fill(0, 255, 0);
            text(str(angle) + " deg", width - 50, y - 20);
        }
    }
    strokeWeight(1);
}

final int LF = 10;
void serialEvent(Serial p) {
    if (p != null && p.available() > 0) {
        String readString = p.readStringUntil(LF);

        if (readString == null) {
            return;
        } else if (readString.equals("###")) {
            receivedValues.clear();
            dataPoints = 0;
        } else {
            try {
                receivedValue = Integer.parseInt(readString.trim());
                if (receivedValues.size() > 3000) {
                    receivedValues.clear();
                    dataPoints = 0;
                }
                receivedValues.append(receivedValue);
            } catch (Throwable t) {
                println("Unexpected input");
                receivedValues.clear();
                dataPoints = 0;
            }
        }
    }
}

void drawNA() {
    stroke(255, 0, 0);
    line(0, 0, width, height);
    line(0, height, width, 0);
}