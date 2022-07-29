#!/usr/bin/env python3
"""
*****
*****
*****
*****
*****
*****
*****
"""
import random
import time


class Block:
    def __init__(self, number, isnum = True):
        self.number = number
        self.num = isnum

    def __str__(self):
        return self.number

class Field:
    def __init__(self, block: Block, w, h):
        self.sign = block
        self.field = [[self.sign for i in range(w)] for i in range(h)]
        self.width = w
        self.height = h

    def __str__(self):
        t = ''
        for i in range(self.height):
            for j in range(self.width):
                if self.field[i][j].num:
                    if self.field[i][j].number > 9999:
                        t += str(self.field[i][j].number)[:-3] + 'k' + " " * (10 - len(str(self.field[i][j].number)[:-3] + 'k'))
                    else:
                        t += str(self.field[i][j].number) + " " * (10 - len(str(self.field[i][j].number)))
                else:
                    t += str(self.field[i][j].number) + " " * (10 - len(str(self.field[i][j].number)))
                t += "    "
            t += '\n'
        return t

def place(x, block: Block):
    if x >= f.width:
        x = f.width - 1
    elif x < 0:
        x = 0
    if f.field[-1][x].number != f.sign.number:
            return False
    y = []
    for i in range(f.height):
        y.append(f.field[i][x])
    while f.sign in y:
        y.remove(f.sign)

    f.field[len(y)][x] = block
    return True

def replace(number, x1, y1, x2, y2):
    newblock = Block(number)
    f.field[x1][y1] = newblock
    f.field[x2][y2] = f.sign


def movedown(i, j):
    f.field[i][j], f.field[i-1][j] = f.field[i-1][j], f.field[i][j]

def merge():
    merged = False
    for j in range(f.width):
        for i in range(f.height - 1, 0, -1):
            if f.field[i][j].number == f.field[i-1][j].number and f.field[i][j].number != f.sign.number:
                replace(f.field[i][j].number * 2, i-1, j, i, j)
                merged = True
    for i in range(f.height):
        for j in range(f.width - 1):
            if f.field[i][j].number == f.field[i][j+1].number and f.field[i][j].number != f.sign.number:
                replace(f.field[i][j].number * 2, i, j, i, j+1)
                merged = True
    for j in range(f.width):
        for i in range(f.height - 1, 0, -1):
            if f.field[i][j].num and not f.field[i-1][j].num:
                movedown(i, j)
                merged = True
    return merged

def maxblock():
    m = 0
    for i in range(f.height):
        for j in f.field[i]:
            if j.num:
                if j.number > m:
                    m = j.number
    return m

class Bot:
    def __init__(self):
        while True:
            print(f)
            num = Block(random.choice(blocks))
            col = self.move(num)

            place(col, num)

            m = merge()
            while m:
                m = merge()

            if maxblock() >= blocks[-2] ** 2:
                deleted = blocks.pop(0)
                blocks.append(blocks[-1] * 2)
                for i in range(f.height):
                    for j in range(f.width):
                        if f.field[i][j].number == deleted:
                            f.field[i][j] = sign

            time.sleep(0.5)

    def move(self, block):
        columns = []
        for j in range(f.width):
            column = []
            for i in range(f.height):
                column.append(f.field[i][j])
            columns.append(column)

        for i in range(len(columns)):
            try:
                lstblock = columns[i].index(f.sign) - 1
            except:
                lstblock = -1
            if columns[i][lstblock].num:
                if columns[i][lstblock].number == block.number:
                    return i
                elif columns[i][lstblock].number > block.number:
                    return i
        return random.randint(0, 4)


class Player:
    def __init__(self):
        global f
        num = random.choice(blocks)
        while True:
            print(f)
            try:
                col = int(input(f'Куда поставить {num}? ')) - 1

                if lose(col):
                    print('You lose! ;(')
                    if not input('Do you want to play again? (y - yes, n - no) ').lower() == 'y':
                        break
                    f = Field(sign, 5, 7)
                else:
                    # for debugging
                    # num, col = map(int, input().split())

                    userblock = Block(num)
                    place(col, userblock)

                    m = merge()
                    while m:
                        m = merge()

                    if maxblock() >= blocks[-2] ** 2:
                        deleted = blocks.pop(0)
                        blocks.append(blocks[-1] * 2)
                        for i in range(f.height):
                            for j in range(f.width):
                                if f.field[i][j].number == deleted:
                                    f.field[i][j] = sign
                    num = random.choice(blocks)

            except:
                print('incorrect input')

def lose(num):
    if sign.number not in str(f):
        return True
    if f.field[-1][num].number != sign.number:
        return True
    return False

blocks = [2, 4, 8, 16, 32, 64, 128]
if __name__=='__main__':
    global sign, f
    sign = Block('*', isnum=False)
    f = Field(sign, 5, 7)
    Player()
