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

// This is a header for the controller implementation
// WARNING: Do not edit this file (unless reconfiguring PCB)
//
// Last edited: 2018-03-16
// Contributor: Muchen He

#ifndef LCALL3_H
#define LCALL3_H

// Pin layouts
// Encoder input pins (uses pin change interrupts)
#define ENCODER0_A 10   /* PORTB BIT2 */
#define ENCODER0_B 9    /* PORTB BIT1 */
#define ENCODER1_A 8    /* PORTB BIT0 */
#define ENCODER1_B 7    /* PORTD BIT7 */

// PWM motor control pins
#define MOTOR0_EN 6
#define MOTOR1_EN 5

// Directional control pins
#define MOTOR0_DIRECA A0
#define MOTOR0_DIRECB A2
#define MOTOR1_DIRECA A1
#define MOTOR1_DIRECB A3

// Homing pins
#define HOMING0 A6
#define HOMING1 A7

// I2C line uses A4 and A5 (reserved)

// Laser control
#define LASER_CONTROL 11

// Communication
#define RX_PIN 0
#define TX_PIN 1

// Misc
#define ONBOARD_LED 13

// User interfacing
#define BTN_A 2
#define BTN_B 3

#endif
