#! /usr/bin/python3

import pygame
from random import random, randint

pygame.init()
pygame.font.init() 


width = 800
height = 450

WHITE = (255, 255, 255)
BLACK = (0,0,0)

MAX_BUNNIES = 50000
MAX_BATCH_ELEMENTS = 8192

class Bunny:
    x = 0.0
    y = 0.0
    dx = 0.0
    dy = 0.0
    color = (0,0,0)

screen = pygame.display.set_mode((width, height))
pygame.display.set_caption("Pygame [textures] example - bunnymark")

clock = pygame.time.Clock()
FPS = 60  # This variable will define how many frames we update per second.

texBunny = pygame.image.load('wabbit_alpha.png').convert_alpha()

bunnies = [Bunny() for i in range(MAX_BUNNIES)] 

bunniesCount=0

sysfont = pygame.font.SysFont(None, 30)

while True:

    dt = clock.tick(FPS)

    for event in pygame.event.get():
        if event.type == pygame.QUIT:  # The user pressed the close button in the top corner of the window.
            quit()

    if pygame.mouse.get_pressed()[0] == 1:
        for i in range(0,100):
            if bunniesCount < MAX_BUNNIES :
                bunnies[bunniesCount].x = float(pygame.mouse.get_pos()[0])
                bunnies[bunniesCount].y = float(pygame.mouse.get_pos()[1])                     
                bunnies[bunniesCount].dx = float(randint(-250, 150))/60.0
                bunnies[bunniesCount].dy = float(randint(-250, 150))/60.0
                bunnies[bunniesCount].color = ( randint(50, 240), randint(80, 240), randint(100, 240) )
                bunniesCount += 1

      
    for i in range(bunniesCount):
        bunny = bunnies[i]
        bunny.x += bunny.dx
        bunny.y += bunny.dy

        if (((bunny.x + texBunny.get_size()[0]/2) > width) or ((bunny.x + texBunny.get_size()[0]/2) < 0)):
            bunny.dx *= -1
        if (((bunny.y + texBunny.get_size()[1]/2) > height) or ((bunny.y + texBunny.get_size()[1]/2 - 40) < 0)):
            bunny.dy *= -1
    
    screen.fill(WHITE)

    for i in range(bunniesCount):        
        tb= pygame.Surface.copy(texBunny)
        tb.fill(bunnies[i].color, special_flags=pygame.BLEND_MULT)
        screen.blit(tb, (bunnies[i].x, bunnies[i].y))
  
    pygame.draw.rect(screen, BLACK, [0, 0, width, 40], 0)
    
    textsurface = sysfont.render("bunnies: "+str(bunniesCount), False, (0, 255, 0))
    screen.blit(textsurface, (120,10))
  
    textsurface = sysfont.render("batched draw calls: "+ str(int(1 + bunniesCount/MAX_BATCH_ELEMENTS)), False, ( 190, 33,  55  ))
    screen.blit(textsurface, (320,10))
  
    textsurface = sysfont.render(str(int(1000/dt))+" FPS", False, (0, 128, 0))
    screen.blit(textsurface, (10,10))

    pygame.display.update()
