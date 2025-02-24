# 🎮 Cub3D

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen)]()
[![Version](https://img.shields.io/badge/version-1.0.0-blue)]()

A Wolfenstein 3D-inspired raycasting engine implemented in C. This project creates a 3Dish perspective from a 2D map using raycasting techniques, providing a first-person view experience.

## 📋 Table of Contents
<details>
<summary>Click to expand</summary>

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Raycasting Engine](#raycasting-engine)
- [Technical Implementation](#technical-implementation)
- [License](#license)

</details>

## ✨ Features
<details>
<summary>Click to expand</summary>

- **3D Rendering**: Real-time rendering using raycasting techniques
- **Textured Walls**: Support for different wall textures
- **Player Movement**: Smooth movement and rotation controls
- **Map Parsing**: Custom map format support with validation
- **Collision Detection**: Prevents walking through walls
- **Minimap**: Optional 2D representation of the game world
- **Performance Optimization**: Efficient rendering algorithms
- **Error Handling**: Robust input validation and error messaging

</details>

## 🎯 Raycasting Engine
![diagram](https://github.com/user-attachments/assets/f6c007be-ee82-4c41-a90b-735c7c25c054)

The heart of Cub3D is its raycasting engine, which creates a 3D perspective by casting rays from the player's position. Here's how it works:

## 🔧 Technical Implementation

### Ray Casting Process

### 1. Camera Ray Calculation
For each column of pixels on the screen, a ray is cast from the player's position into the virtual world. The position of the ray on the camera plane is determined relative to the center of the screen.

- **Camera Plane and Ray Position**:
  The position of the ray on the camera plane is calculated using the formula:
  
  ```C
  cub->ray->camera_x = 2 * x / (double)WIDTH - 1;
  ```
  
  Where `x` is the current column being processed. This calculation maps the column to a range between -1 and 1, corresponding to the left and right edges of the camera plane, respectively.

- **Ray Direction Calculation**:
  The direction of the ray is computed by combining the player's direction vector with a portion of the camera plane vector, scaled by `camera_x`:
  
  ```C
  cub->ray->ray_x = cub->ray->dir_x + cub->ray->plan_x * cub->ray->camera_x;
  cub->ray->ray_y = cub->ray->dir_y + cub->ray->plan_y * cub->ray->camera_x;
  ```

### 2. Step and Side Distance Initialization
This step establishes the direction to step in (either left/right or up/down) based on the ray's direction and calculates the initial side distance.

- **Step Direction**:
  Depending on the sign of `ray_x` and `ray_y`, the step direction for x and y (`step_x`, `step_y`) are determined (either +1 or -1).

- **Initial Side Distance**:
  This is the distance the ray has to travel from the starting point to reach the first x-side or y-side of the map grid it encounters.

  ```C
  cub->ray->side_dist_x = (cub->ray->ray_x < 0) ? (cub->ray->p_x - cub->ray->map_x) * cub->ray->delta_x
                                                : (cub->ray->map_x + 1.0 - cub->ray->p_x) * cub->ray->delta_x;
  cub->ray->side_dist_y = (cub->ray->ray_y < 0) ? (cub->ray->p_y - cub->ray->map_y) * cub->ray->delta_y
                                                : (cub->ray->map_y + 1.0 - cub->ray->p_y) * cub->ray->delta_y;
  ```

### 3. Digital Differential Analysis (DDA)
This loop advances the ray through the map grid cell by cell until it hits a wall.

- **DDA Loop Execution**:
  The ray is advanced to the next map square using the `step_x` and `step_y` variables until a wall is encountered.

### 4. Perpendicular Wall Distance Calculation
Once a wall is hit, the perpendicular distance to the wall is calculated to avoid fisheye distortion
.

- **Distance Calculation**:
  Depending on whether the wall was hit on a horizontal or vertical side, the correct distance component (`side_dist_x` or `side_dist_y`) is used to calculate `wall_dist`.

### 5. Wall Slice Rendering
The height of the wall slice that should be drawn on the screen is calculated based on the distance to the wall, and the appropriate texture coordinates are chosen.

### 6. Memory Management

- Efficient texture caching
- Optimized buffer management
- Clean resource allocation/deallocation


## 🚀 Installation
<details>
<summary>Click to expand</summary>

### Prerequisites
- GCC compiler
- Make
- MinilibX library (X11 development files)

### Steps

1. Clone the repository:
```bash
git clone https://github.com/Bengschor/cub3d.git
cd cub3d
```

2. Install dependencies (Ubuntu/Debian):
```bash
sudo apt-get install gcc make xorg libxext-dev libbsd-dev
```

3. Compile the project:
```bash
make bonus
```

</details>

## 💻 Usage
<details>
<summary>Click to expand</summary>

1. Launch the game with a map file:
```bash
./cub3D maps/default.cub
```

2. Controls:
```
W/S - Move forward/backward
A/D - Strafe left/right
←/→ - Rotate camera left/right
↑/↓ - Activate/desactivate map
M (if map is activated) - Full screen map

ESC - Exit game
```

3. Map file format:
```
NO ./path_to_north_texture.xpm    # North texture
SO ./path_to_south_texture.xpm    # South texture
WE ./path_to_west_texture.xpm     # West texture
EA ./path_to_east_texture.xpm     # East texture

# Map layout (1 for walls, 0 for empty space, N/S/E/W for player start position)
111111
100001
10N001
100001
111111
```

</details>

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
