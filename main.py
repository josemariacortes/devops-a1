import dice
from time import sleep

print(dice.__version__)

# Configuración de la tirada con Constantes globales
DICE_AMOUNT = 6
DICE_SIDES = 20

def roll(amount:int, sides:int):
    return dice.roll(f'{amount}d{sides}')

for idx, result in enumerate(roll(DICE_AMOUNT, DICE_SIDES)):
    print(f'Lanzamiento {idx+1} número obtenido {result}', flush=True)
    sleep(2)