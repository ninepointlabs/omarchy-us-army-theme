# US Army theme for Omarchy

Olive drab and Army gold, with a wallpaper built from authentic division
insignia: the 2nd Infantry Division (Indianhead), 3rd Infantry Division
(Marne), 1st Cavalry Division (First Team), 24th Infantry Division (Taro
Leaf) and 35th Infantry Division (Santa Fe) shoulder sleeve insignia, the
Combat Infantryman Badge, the Purple Heart, and (on the third wallpaper) the
Army Commendation Medal with "V" device and Sergeant (E-5) chevrons.

![Divisions wallpaper](backgrounds/divisions.png)

## Install

```bash
omarchy theme install https://github.com/ninepointlabs/omarchy-us-army-theme
omarchy theme set us-army
```

Or from a checkout: `./install.sh --apply`.

## Backgrounds

- `divisions.png`: the five patches, the CIB and the Purple Heart.
- `combat-infantryman.png`: just the CIB over the Purple Heart, for a quieter desk.
- `decorations.png`: the first wallpaper plus the Army Commendation Medal with
  "V" device beside the Purple Heart.
- `sergeant.png`: the same, with Sergeant (E-5) chevrons between the medals.

All four are 3840x2160. Cycle with `omarchy theme bg next`.

## Palette

| Role       | Colour    |
|------------|-----------|
| Accent     | `#C9A227` Army gold |
| Background | `#1E2419` olive drab |
| Foreground | `#EAE4D3` khaki cream |
| Red        | `#C8312F` Taro Leaf red |
| Blue       | `#3F63C5` Marne blue |
| Yellow     | `#D9B33A` First Team yellow |
| Magenta    | `#8B5CC8` Purple Heart |

See [`colors.toml`](colors.toml) for the full set.

## The insignia

All of the artwork is official US Army insignia, which as work of the
United States federal government is in the public domain. The vector files
in `assets/` were taken from Wikimedia Commons; `assets/SOURCES.md` lists
each file, its licence and its source page. `build-wallpapers.sh`
regenerates the wallpapers from them with ImageMagick and librsvg.

The theme itself is MIT.
