import random

class Character:
    def __init__(self, hp, str, mag, spd, skl, lck, defn, res, weapon):
        self.hp = hp
        self.str = str
        self.mag = mag
        self.spd = spd
        self.skl = skl
        self.lck = lck
        self.defn = defn
        self.res = res
        self.weapon = weapon

class Weapon:
    def __init__(self, type, might, hit, crit, weight):
        self.type = type
        self.might = might
        self.hit = hit
        self.crit = crit
        self.weight = weight

def CalculateHit(player):
    hit = player.skl * 1.5 + player.lck * 0.5
    # if player.cls == "Sniper":
    #   hit += 5
    hit += player.weapon.hit
    return hit

def CalculateAttackSpeed(player):
    weight = player.weapon.weight - (player.str/5)
    #plus terrain bonus and weapon advantage
    return player.spd - weight

def WeaponTriangle(player, enemy):
    modifier = 0
    if player.weapon.type == sword and enemy.weapon.type == lance:
        modifier = -5
    elif player.weapon.type == sword and enemy.weapon.type == axe:
        modifier = 5
    elif player.weapon.type == lance and enemy.weapon.type == axe:
        modifier = -5
    elif player.weapon.type == lance and enemy.weapon.type == sword:
        modifier = 5
    elif player.weapon.type == axe and enemy.weapon.type == sword:
        modifier = 5
    elif player.weapon.type == axe and enemy.weapon.type == lance:
        modifier = 5
    return modifier

def CalculateHitPercentage(player, enemy,):
    percentage = CalculateHit(player) - CalculateAttackSpeed(enemy) + WeaponTriangle(player, enemy)
    if percentage > 100:
        percentage = 100
    return percentage

def Attack(player, enemy):
    rngCalculation = random.randint(0, 100)
    if rngCalculation < CalculateHitPercentage(player, enemy):
        if player.weapon.type == "sword" or "lance" or "axe":
            damage = player.str + player.weapon.might - enemy.defn
        else:
            damage = player.mag + player.weapon.might - enemy.res
        enemy.hp -= damage
        print("Attacking unit dealt " + str(damage) + " to defending unit")
    else:
        print("Attacking unit missed!")

def Dead(unit):
    if unit.hp <= 0:
        print("Unit is dead!")
        return True
    return False

def Combat(player, enemy):
    #Attacks twice if attack speed if 5 greater.
    if (CalculateAttackSpeed(player) - CalculateAttackSpeed(enemy)) > 5:
        print("Attacker Phase")
        Attack(player,enemy)
        if not Dead(enemy):
            #enemy gets to attack back
            print("Retaliation")
            Attack(enemy, player)
            if not Dead(player):
                #This is when player makes a follow up
                print("Attacker Phase")
                Attack(player,enemy)
    else:
        print("Attacker Phase")
        Attack(player, enemy)
        if not Dead(enemy):
            print("Retaliation")
            Attack(enemy,player)

sword = Weapon("sword", 12, 60, 0, 3)
lance = Weapon("lance", 10, 70, 3, 4)
axe = Weapon("axe", 15, 50, 5, 5)
magic = Weapon("magic", 12, 50, 0, 1)

player = Character(10, 6, 3, 4, 4, 6, 2, 2, None)
enemy = Character(6, 5, 1, 8, 2, 7, 1, 5, None)

weaponName = input("What weapon would you like the player to hold? (sword, lance, axe, or magic): ")
if weaponName == sword.type:
    player.weapon = sword
elif weaponName == lance.type:
    player.weapon = lance
elif weaponName == axe.type:
    player.weapon = axe
else:
    player.weapon = magic

weaponName = input("What weapon would you like the enemy to hold? (sword, lance, axe): ")
if weaponName == sword.type:
    enemy.weapon = sword
elif weaponName == lance.type:
    enemy.weapon = lance
elif weaponName == axe.type:
    enemy.weapon = axe
else:
    enemy.weapon = magic

phase = input("Is it player phase or enemy phase? ")

if phase == "player":
    print("Player attacking enemy")
    print("Player's hit rate: " + str(CalculateHit(player)))
    print("Enemy's Avoid rate: " + str(CalculateAttackSpeed(enemy)))
    print("Hit percentage: " + str(CalculateHitPercentage(player, enemy)))
    Combat(player, enemy)
else:
    print("Enemy attacking player")
    print("Enemy's hit rate: " + str(CalculateHit(enemy)))
    print("Player's Avoid rate: " + str(CalculateAttackSpeed(player)))
    print("Hit percentage: " + str(CalculateHitPercentage(enemy, player)))
    Combat(enemy, player)

