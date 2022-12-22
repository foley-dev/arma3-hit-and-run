# Hit and Run

![Loading screen](https://raw.githubusercontent.com/foley-dev/arma3-hit-and-run/assets/screenshots/loading.jpg)

*“The conventional army loses if it does not win.\
&#160;&#160;&#160;&#160;The guerilla wins if he does not lose.”*

## About

* Co-op
* Map: **Altis**
* Player count: **18**
* Typical duration: **30 min - 50 min**
* [Mod dependencies](https://raw.githubusercontent.com/foley-dev/arma3-hit-and-run/assets/tour_modset.html) (load into Arma 3 Launcher)

## Briefing

> The AAF unit stationed at *FOB Gamekeeper* is heading out on a patrol of the woods. The patrol is composed of an infantry platoon backed by a few BRDMs. The *expected route* has been sketched on your maps. Keep in mind that BRDMs tend to follow the roads.\
\
**The patrol has just moved out at a walking pace.**\
\
Your goal is to:\
**1. Ambush and harass the enemy patrol**\
**2. Once it's too hot, escape *off the shore***\
\
Beware of reinforcements! If the patrol suffers casualties, more units will show up. The *BMPs* might get involved if we put up a good fight. Be agile, your goal is not to defeat the enemy but to wear them down.

## Scripting highlights

* **UAZ customization `scripts/player/garage/initGarage.sqf`**
    * Mount weapons
    * Change paint
    * Other cosmetic changes
* Ability for the commander to select and redraw enemy patrol route in briefing `scripts/player/briefing.sqf`
* Random variations of equipment available in Arsenal `scripts/player/arsenal.sqf`
* Victory conditions scaled based on player count `scripts/server/tasks.sqf`
* Needlessly over-engineered AI behaviour `scripts/server/ai.sqf`
    * 4 squad patrol follows a sensible path through the AO
    * Squads slow down or speed up in order to stick together
    * Vehicles follow the infantry squads as best they can given terrain constraints (i.e. avoid driving into woods)
    * Reinforcements join in when enemy takes certain % of casualties
    * AI skill starts off easy but gets higher as game progresses
    * Various patches and fallbacks to prevent AI from getting stuck and left behind 

## Screenshots

![Screenshot](https://raw.githubusercontent.com/foley-dev/arma3-hit-and-run/assets/screenshots/1.jpg)

![Screenshot](https://raw.githubusercontent.com/foley-dev/arma3-hit-and-run/assets/screenshots/2.jpg)

![Screenshot](https://raw.githubusercontent.com/foley-dev/arma3-hit-and-run/assets/screenshots/3.jpg)

![Screenshot](https://raw.githubusercontent.com/foley-dev/arma3-hit-and-run/assets/screenshots/4.jpg)

![Screenshot](https://raw.githubusercontent.com/foley-dev/arma3-hit-and-run/assets/screenshots/5.jpg)

## Playable slots

### Command

* Cell Leader
* Medic
* Drone Operator

### Alpha

* Team Leader
* Machinegunner
* Machinegunner
* Explosive Technician
* Rifleman

### Bravo

* Team Leader
* Anti-tank
* Anti-tank
* Explosive Technician
* Rifleman

### Tango

* Crew Chief
* Crewman
* Crewman

### Sierra

* Scout
* Sharpshooter
