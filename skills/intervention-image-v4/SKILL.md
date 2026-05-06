---
name: intervention-image-v4
description: >-
  Use when manipulating images in PHP with Intervention Image v4: ImageManager,
  GD/Imagick/Vips drivers, decode/decodePath/encodeUsingFormat, Format enum,
  inserting watermarks, migrating from v3, exception hierarchy, or PHP ≥8.3.
metadata:
  category: reference
  triggers:
    - intervention/image
    - Intervention Image 4
    - ImageManager::usingDriver
    - decodePath
    - decodeBinary
    - encodeUsingFormat
    - Format::
    - Alignment::
    - PHP 8.3 image
    - upgrade intervention image v3
    - DecoderException
    - composer intervention/image
    - insert watermark
---

# Intervention Image v4 (PHP)

Fluent API over **GD**, **Imagick**, or **libvips** (via add-on driver). **Authoritative detail** lives in local docs under `references/docs/` (mirrored from the v4 documentation set).

## When to use

- Implementing **resize**, **insert** (watermarks/overlays), **draw/text**, **effects**, or **animations** in PHP on **v4**
- Choosing or configuring **ImageManager** and drivers (`autoOrientation`, `decodeAnimation`, `backgroundColor`, `strip`)
- **Decoding** paths, binary, Base64, data URIs, streams, uploads (`SplFileInfo`), or **creating** canvases / animated sequences via **`createImage()`**
- **Encoding** with **`encodeUsingFormat()`**, **`encodeUsingMediaType()`**, **`encodeUsingPath()`**, **`save()`**, and **`EncodedImageInterface`**
- **Migrating from v3** (method renames, encoding API, exceptions) or debugging **decode/encode** failures

## Quick reference

| Topic | Local doc |
| --- | --- |
| Intro & feature summary | `references/docs/getting-started/introduction.md` |
| PHP ≥8.3, extensions, Composer | `references/docs/getting-started/installation.md` |
| Format matrix (GD vs Imagick vs Vips) | `references/docs/getting-started/formats.md` |
| Upgrade from v3 | `references/docs/getting-started/upgrade.md` |
| Framework notes | `references/docs/getting-started/frameworks.md` |
| `ImageManager`, drivers, options | `references/docs/getting-started/configuration-drivers.md` |
| `decode*()`, `createImage()`, decoders | `references/docs/basics/instantiation.md` |
| Encoders, `encodeUsing*()`, `save()`, encoded output | `references/docs/basics/image-output.md` |
| Exception hierarchy | `references/docs/basics/error-handling.md` |
| Colors, color spaces | `references/docs/basics/colors.md` |
| EXIF, resolution, ICC | `references/docs/basics/meta-information.md` |
| Resizing, effects, drawing, text, animations, extensions | `references/docs/modifying-images/` |

### Minimal flow (from docs)

```php
use Intervention\Image\ImageManager;
use Intervention\Image\Drivers\Gd\Driver;
use Intervention\Image\Alignment;
use Intervention\Image\Format;

$manager = ImageManager::usingDriver(Driver::class);

$image = $manager->decodePath('images/example.webp');
$image->scale(height: 300);
$image->insert('images/watermark.png', alignment: Alignment::BOTTOM_RIGHT);

$encoded = $image->encodeUsingFormat(Format::JPEG, quality: 65);
$encoded->save('images/example.jpg');
```

Prefer **`ImageManager::usingDriver(Driver::class, ...)`** or **`new ImageManager(Driver::class, ...)`** with named config options; access the active driver via the manager’s public **`$driver`** property (there is no `driver()` accessor on the manager in v4).

## Agent workflow

1. **Confirm v4** (`intervention/image` current major in Composer) and **PHP ≥ 8.3** per `getting-started/installation.md`.
2. **Configure the manager** from `getting-started/configuration-drivers.md`; check **format support** in `formats.md` and driver capabilities as needed.
3. **Pick the right decoder**: universal **`decode($source, $decoders)`** vs **`decodePath` / `decodeBinary` / `decodeBase64` / `decodeDataUri` / `decodeSplFileInfo` / `decodeStream`** in `basics/instantiation.md`.
4. For **errors**, use `basics/error-handling.md` (e.g. **`DecoderException`** under **`DriverException`**).
5. For **output**, use `basics/image-output.md` (`encodeUsingFormat`, `encodeUsingMediaType`, `encodeUsingPath`, `encodeUsingFileExtension`, and **`Image::save`** vs **`EncodedImageInterface::save`**).
6. For **editing**, open the relevant file under `references/docs/modifying-images/` (including **`custom-extensions.md`** for custom modifiers/extensions).

## Common mistakes

| Issue | Notes |
| --- | --- |
| **v3 habits on v4** | Replace **`read()`** with **`decode()`** / **`decodePath()`** etc.; replace **`toJpeg()`/`toPng()`** with **`encodeUsingFormat(Format::...)`**; replace **`place()`** with **`insert()`** (signature changed—see `upgrade.md`). |
| **`save()` on `Image` vs encoded** | **`Image::save`** only handles **known image extensions**; use **`EncodedImageInterface::save()`** when the target extension is not recognized (`image-output.md`). |
| **GD and EXif** | GD driver **drops Exif on encode**; prefer Imagick/Vips when metadata matters (`configuration-drivers.md`). |
| **Wrong format on a driver** | Animated WebP, TIFF, HEIC, etc. are **not universally available**—see `formats.md` and runtime capability checks. |
| **Migration surprises** | Examples: **`pad()` → `containDown()`**, **`flop()` removed** (use **`flip()`** with horizontal direction), **`pickColor()` → `colorAt()`**, config **`blendingColor` → `backgroundColor`** (`upgrade.md`). |

## Limitations

- This skill **does not** replace reading the full topic file: API parameters, edge cases, and driver-specific caveats are in `references/docs/`.
- **Official online docs** may be newer than the mirrored files; prefer the mirror for offline consistency, then verify against [Intervention Image v4](https://image.intervention.io/v4) if something disagrees.
