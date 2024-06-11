//Programa: Display LCD 16x2 e modulo I2C
//Autor: Arduino e Cia

#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include "Funcion_calculo.h"

//Inicializa o display no endereco 0x27
LiquidCrystal_I2C lcd(0x27,16,2);
 
void setup()
{
  //Serial.begin(9600);
  
 lcd.init();
 Funcion_calculo();
 lcd.setBacklight(HIGH);

}
 
void loop()
{
  int linha = 1;
  for (int i = 0; i<= 9; i++){
    lcd.clear(); 
    uint16_t teste = function_busca_resultado(0x0100+i);
    lcd.setCursor(0,0);
    lcd.print("Equacao ");
    lcd.print(linha);
    lcd.print(": ");
    lcd.print(teste, DEC);
    delay(1500);
    linha++;
    i++;
  }
}
