#include "driver/gpio.h"
#include "esp32-hal-timer.h"

volatile uint16_t count1 = 0;
volatile uint16_t count2 = 0;
volatile uint16_t count3 = 0;
volatile uint16_t count4 = 0;
volatile uint16_t count5 = 0;

volatile uint16_t delay1 = 0;
volatile uint16_t delay2 = 0;
volatile uint16_t delay3 = 0;
volatile uint16_t delay4 = 0;
volatile uint16_t delay5 = 0;

// Interspeaker distance
volatile uint16_t interspace = 100;
// Steering angle
volatile uint16_t angle = 100;
// Wavelength
volatile uint16_t wavelength = 100;
// Wave period
volatile uint16_t period = 13;

hw_timer_t * timer = NULL;
portMUX_TYPE timerMux = portMUX_INITIALIZER_UNLOCKED;

// Fast GPIO toggle macro using direct register access
#define TOGGLE_PIN(pin) REG_WRITE(GPIO_OUT_REG, REG_READ(GPIO_OUT_REG) ^ (1UL << pin))

// ISR
void IRAM_ATTR onTimer()
{
  portENTER_CRITICAL_ISR(&timerMux);

  if (--count1 == 0)
  {
    TOGGLE_PIN(5);
    count1 = period;
  }
  if (--count2 == 0)
  {
    TOGGLE_PIN(18);
    count2 = period;
  }
  if (--count3 == 0)
  {
    TOGGLE_PIN(19);
    count3 = period;
  }
  if (--count4 == 0)
  {
    TOGGLE_PIN(20);
    count4 = period;
  }
  if (--count5 == 0)
  {
    TOGGLE_PIN(21);
    count5 = period;
  }

  portEXIT_CRITICAL_ISR(&timerMux);
}

void setup()
{
  // Pin initialization
  pinMode(5, OUTPUT);
  pinMode(18, OUTPUT);
  pinMode(19, OUTPUT);
  pinMode(20, OUTPUT);
  pinMode(21, OUTPUT);

  // Count value initialization
  count1 = period + delay1;
  count2 = period + delay2;
  count3 = period + delay3;
  count4 = period + delay4;
  count5 = period + delay5;

  // Timer setup for ESP32-S3
  timer = timerBegin(0); // Only one argument in newer core
  timerAttachInterrupt(timer, &onTimer); // No edge argument
  timerWrite(timer, 0); // Reset timer count
  timerAlarm(timer, 1, true, 1); //Fires every 1 µs, auto-reloads
}

void loop()
{
  // ISR handles everything
}
