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

void setup() {
    pinMode(10, OUTPUT);
    Serial.begin(9600);
}

String msg;
int pwm = 0;
void loop() {
    if (Serial.available()  > 0) {
        msg = Serial.readString();
        pwm = msg.toInt();
        Serial.println(pwm, DEC);
    }
    analogWrite(10, pwm);
    digitalWrite(6, 1);
    digitalWrite(7, 0);
}
