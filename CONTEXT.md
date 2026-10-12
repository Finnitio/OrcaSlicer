# Slicing: surfaces and bridging

How a sliced layer's areas are classified and which ones are printed as bridges.

## Language

**Slope angle**:
The angle between a model surface and the horizontal: 0° is flat, 90° is a vertical wall.
_Avoid_: overhang angle (that is measured from vertical), "70–80°" meaning a shallow slope

**Shallow slope**:
An upward-facing surface with a small slope angle, so that each layer's top-shell strip extends only a little beyond the layer below.
_Avoid_: sloped wall, sloped outer wall

**Outline step**:
How far a layer's outline lies inside the outline of the layer below, measured at one spot. On a shallow slope it is about layer height / tan(slope angle).
_Avoid_: recession, overhang width

**Walled slope**:
A part of a shallow slope whose outline step is narrower than the wall band, so the visible surface is printed entirely as walls with no top-surface infill.
_Avoid_: sloped outer wall, sloped wall

**Slope strip**:
The narrow strip of solid infill just inside the walls of a walled slope that rests on sparse infill, about one outline step wide on every layer.
_Avoid_: sloped shell

**Strip path**:
The bridge path printed in a slope strip, running parallel to the outline at a fixed inset, like an extra wall loop.
_Avoid_: scaled outer wall, bridge wall

**Steep-end threshold**:
The smallest outline step, as a multiple of the solid infill line width, at which a slope strip is still printed as a strip path. Slopes steeper than this are treated as supported.
_Avoid_: the parameter, slope threshold, min angle

**Pillowing**:
Bumps and dips on a printed surface that repeat with the sparse infill grid underneath, because the solid layers below sagged between infill lines.
_Avoid_: sag artifacts, rough slope

**Internal bridge**:
Solid infill printed with bridge flow and speed where it rests on sparse infill rather than on solid material.
_Avoid_: bridge layer, internal bridging infill

**Bridge filter**:
The rule that drops candidate internal bridges that are too narrow or too small to be worth bridging.
_Avoid_: short-bridge filter
