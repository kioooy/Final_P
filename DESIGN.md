---
version: alpha
name: TechZone AI
description: >
  A Material Design 3 design system for a premium technology e-commerce
  mobile application. Built for two user experiences — a consumer-facing
  storefront and an administrative back-office — unified by a vibrant
  orange brand identity.
colors:
  # ── Primary (Orange) ──────────────────────────────────────────────
  primary: "#E8611A"
  on-primary: "#FFFFFF"
  primary-container: "#FFDBC9"
  on-primary-container: "#341100"
  inverse-primary: "#FFB690"

  # ── Secondary (Warm Slate) ────────────────────────────────────────
  secondary: "#76574B"
  on-secondary: "#FFFFFF"
  secondary-container: "#FFDBC9"
  on-secondary-container: "#2C160C"

  # ── Tertiary (Teal Accent) ────────────────────────────────────────
  tertiary: "#006B5E"
  on-tertiary: "#FFFFFF"
  tertiary-container: "#74F8E0"
  on-tertiary-container: "#00201B"

  # ── Error ─────────────────────────────────────────────────────────
  error: "#BA1A1A"
  on-error: "#FFFFFF"
  error-container: "#FFDAD6"
  on-error-container: "#410002"

  # ── Neutral / Surface ────────────────────────────────────────────
  surface: "#FFFBFF"
  surface-dim: "#E4D8D1"
  surface-bright: "#FFFBFF"
  surface-container-lowest: "#FFFFFF"
  surface-container-low: "#FEF1EB"
  surface-container: "#F8EBE5"
  surface-container-high: "#F3E5DF"
  surface-container-highest: "#EDE0DA"
  on-surface: "#201A17"
  on-surface-variant: "#52443C"
  inverse-surface: "#362F2B"
  inverse-on-surface: "#FBEEE8"
  outline: "#85746B"
  outline-variant: "#D7C2B8"
  surface-tint: "#E8611A"
  background: "#FFFBFF"
  on-background: "#201A17"
  surface-variant: "#F4DED4"

  # ── Extended Palette ──────────────────────────────────────────────
  success: "#2E7D32"
  on-success: "#FFFFFF"
  warning: "#F9A825"
  on-warning: "#1C1400"
  info: "#1565C0"
  on-info: "#FFFFFF"
  star-rating: "#FFB300"
  badge-discount: "#D32F2F"
  admin-sidebar: "#1B1B1F"
  admin-sidebar-active: "#E8611A"

typography:
  # ── Display ───────────────────────────────────────────────────────
  display-lg:
    fontFamily: Poppins
    fontSize: 57px
    fontWeight: 400
    lineHeight: 64px
    letterSpacing: -0.25px

  display-md:
    fontFamily: Poppins
    fontSize: 45px
    fontWeight: 400
    lineHeight: 52px

  display-sm:
    fontFamily: Poppins
    fontSize: 36px
    fontWeight: 400
    lineHeight: 44px

  # ── Headline ──────────────────────────────────────────────────────
  headline-lg:
    fontFamily: Poppins
    fontSize: 32px
    fontWeight: 600
    lineHeight: 40px

  headline-md:
    fontFamily: Poppins
    fontSize: 28px
    fontWeight: 600
    lineHeight: 36px

  headline-sm:
    fontFamily: Poppins
    fontSize: 24px
    fontWeight: 600
    lineHeight: 32px

  # ── Title ─────────────────────────────────────────────────────────
  title-lg:
    fontFamily: Poppins
    fontSize: 22px
    fontWeight: 500
    lineHeight: 28px

  title-md:
    fontFamily: Poppins
    fontSize: 16px
    fontWeight: 600
    lineHeight: 24px
    letterSpacing: 0.15px

  title-sm:
    fontFamily: Poppins
    fontSize: 14px
    fontWeight: 600
    lineHeight: 20px
    letterSpacing: 0.1px

  # ── Body ──────────────────────────────────────────────────────────
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: 400
    lineHeight: 24px
    letterSpacing: 0.5px

  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: 400
    lineHeight: 20px
    letterSpacing: 0.25px

  body-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: 400
    lineHeight: 16px
    letterSpacing: 0.4px

  # ── Label ─────────────────────────────────────────────────────────
  label-lg:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: 500
    lineHeight: 20px
    letterSpacing: 0.1px

  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: 500
    lineHeight: 16px
    letterSpacing: 0.5px

  label-sm:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: 500
    lineHeight: 16px
    letterSpacing: 0.5px

rounded:
  none: 0px
  xs: 4px
  sm: 8px
  md: 12px
  lg: 16px
  xl: 28px
  full: 9999px

spacing:
  base: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  xxl: 48px
  screen-padding: 16px
  card-padding: 16px
  card-gap: 12px
  section-gap: 24px
  bottom-nav-height: 80px
  app-bar-height: 56px
  fab-margin: 16px

components:
  # ── Buttons ───────────────────────────────────────────────────────
  button-filled:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-primary}"
    typography: "{typography.label-lg}"
    rounded: "{rounded.xl}"
    height: 48px
    padding: 24px

  button-filled-hover:
    backgroundColor: "#D05516"

  button-outlined:
    backgroundColor: transparent
    textColor: "{colors.primary}"
    typography: "{typography.label-lg}"
    rounded: "{rounded.xl}"
    height: 48px
    padding: 24px

  button-text:
    backgroundColor: transparent
    textColor: "{colors.primary}"
    typography: "{typography.label-lg}"
    padding: 12px

  button-tonal:
    backgroundColor: "{colors.primary-container}"
    textColor: "{colors.on-primary-container}"
    typography: "{typography.label-lg}"
    rounded: "{rounded.xl}"
    height: 48px
    padding: 24px

  button-icon:
    backgroundColor: transparent
    textColor: "{colors.on-surface-variant}"
    rounded: "{rounded.full}"
    size: 48px

  # ── FAB ───────────────────────────────────────────────────────────
  fab-primary:
    backgroundColor: "{colors.primary-container}"
    textColor: "{colors.on-primary-container}"
    rounded: "{rounded.lg}"
    size: 56px

  fab-primary-hover:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-primary}"

  # ── Cards ─────────────────────────────────────────────────────────
  card-elevated:
    backgroundColor: "{colors.surface-container-low}"
    rounded: "{rounded.md}"
    padding: "{spacing.card-padding}"

  card-filled:
    backgroundColor: "{colors.surface-container-highest}"
    rounded: "{rounded.md}"
    padding: "{spacing.card-padding}"

  card-outlined:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.md}"
    padding: "{spacing.card-padding}"

  # ── Product Card ──────────────────────────────────────────────────
  product-card:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.md}"
    padding: 0px

  product-card-image:
    backgroundColor: "{colors.surface-container}"
    rounded: "{rounded.md}"
    height: 160px

  product-card-title:
    textColor: "{colors.on-surface}"
    typography: "{typography.title-sm}"

  product-card-brand:
    textColor: "{colors.on-surface-variant}"
    typography: "{typography.body-sm}"

  product-card-price:
    textColor: "{colors.primary}"
    typography: "{typography.title-md}"

  product-card-rating:
    textColor: "{colors.star-rating}"
    typography: "{typography.label-sm}"

  # ── Input Fields ──────────────────────────────────────────────────
  input-outlined:
    backgroundColor: transparent
    textColor: "{colors.on-surface}"
    typography: "{typography.body-lg}"
    rounded: "{rounded.xs}"
    height: 56px
    padding: 16px

  input-filled:
    backgroundColor: "{colors.surface-container-highest}"
    textColor: "{colors.on-surface}"
    typography: "{typography.body-lg}"
    rounded: "{rounded.xs}"
    height: 56px
    padding: 16px

  # ── Search Bar ────────────────────────────────────────────────────
  search-bar:
    backgroundColor: "{colors.surface-container-high}"
    textColor: "{colors.on-surface}"
    typography: "{typography.body-lg}"
    rounded: "{rounded.xl}"
    height: 56px
    padding: 16px

  # ── Bottom Navigation ─────────────────────────────────────────────
  bottom-nav:
    backgroundColor: "{colors.surface-container}"
    height: "{spacing.bottom-nav-height}"

  bottom-nav-item-active:
    backgroundColor: "{colors.primary-container}"
    textColor: "{colors.on-primary-container}"
    typography: "{typography.label-md}"
    rounded: "{rounded.full}"

  bottom-nav-item-inactive:
    backgroundColor: transparent
    textColor: "{colors.on-surface-variant}"
    typography: "{typography.label-md}"

  # ── Top App Bar ───────────────────────────────────────────────────
  app-bar-small:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.on-surface}"
    typography: "{typography.title-lg}"
    height: "{spacing.app-bar-height}"

  app-bar-medium:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.on-surface}"
    typography: "{typography.headline-sm}"

  # ── Chips ─────────────────────────────────────────────────────────
  chip-filter:
    backgroundColor: "{colors.surface-container-low}"
    textColor: "{colors.on-surface-variant}"
    typography: "{typography.label-lg}"
    rounded: "{rounded.sm}"
    height: 32px
    padding: 16px

  chip-filter-active:
    backgroundColor: "{colors.primary-container}"
    textColor: "{colors.on-primary-container}"

  # ── Badge ─────────────────────────────────────────────────────────
  badge-cart:
    backgroundColor: "{colors.error}"
    textColor: "{colors.on-error}"
    typography: "{typography.label-sm}"
    rounded: "{rounded.full}"
    size: 16px

  badge-notification:
    backgroundColor: "{colors.error}"
    textColor: "{colors.on-error}"
    rounded: "{rounded.full}"
    size: 8px

  # ── List Items ────────────────────────────────────────────────────
  list-item:
    backgroundColor: transparent
    textColor: "{colors.on-surface}"
    typography: "{typography.body-lg}"
    padding: 16px

  list-item-hover:
    backgroundColor: "{colors.surface-container}"

  # ── Cart Item ─────────────────────────────────────────────────────
  cart-item:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.md}"
    padding: "{spacing.card-padding}"

  cart-item-quantity:
    backgroundColor: "{colors.surface-container-high}"
    textColor: "{colors.on-surface}"
    typography: "{typography.label-lg}"
    rounded: "{rounded.sm}"
    height: 32px

  # ── Order Status ──────────────────────────────────────────────────
  order-status-pending:
    backgroundColor: "#FFF3E0"
    textColor: "#E65100"
    typography: "{typography.label-md}"
    rounded: "{rounded.full}"
    padding: 12px

  order-status-processing:
    backgroundColor: "#E3F2FD"
    textColor: "#0D47A1"
    typography: "{typography.label-md}"
    rounded: "{rounded.full}"
    padding: 12px

  order-status-shipping:
    backgroundColor: "#E8F5E9"
    textColor: "#1B5E20"
    typography: "{typography.label-md}"
    rounded: "{rounded.full}"
    padding: 12px

  order-status-delivered:
    backgroundColor: "#E8F5E9"
    textColor: "{colors.success}"
    typography: "{typography.label-md}"
    rounded: "{rounded.full}"
    padding: 12px

  order-status-cancelled:
    backgroundColor: "{colors.error-container}"
    textColor: "{colors.on-error-container}"
    typography: "{typography.label-md}"
    rounded: "{rounded.full}"
    padding: 12px

  # ── Chat Bubbles ──────────────────────────────────────────────────
  chat-bubble-user:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-primary}"
    typography: "{typography.body-md}"
    rounded: "{rounded.lg}"
    padding: 12px

  chat-bubble-ai:
    backgroundColor: "{colors.surface-container-high}"
    textColor: "{colors.on-surface}"
    typography: "{typography.body-md}"
    rounded: "{rounded.lg}"
    padding: 12px

  # ── Admin Dashboard ───────────────────────────────────────────────
  admin-stat-card:
    backgroundColor: "{colors.surface-container-lowest}"
    rounded: "{rounded.lg}"
    padding: 20px

  admin-stat-card-icon:
    backgroundColor: "{colors.primary-container}"
    textColor: "{colors.on-primary-container}"
    rounded: "{rounded.md}"
    size: 48px

  admin-data-table:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.md}"
    padding: 0px

  admin-data-table-header:
    backgroundColor: "{colors.surface-container}"
    textColor: "{colors.on-surface}"
    typography: "{typography.title-sm}"
    padding: 16px

  admin-data-table-row:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.on-surface}"
    typography: "{typography.body-md}"
    padding: 16px

  admin-data-table-row-hover:
    backgroundColor: "{colors.surface-container-low}"

  # ── Dialogs & Sheets ──────────────────────────────────────────────
  dialog:
    backgroundColor: "{colors.surface-container-high}"
    rounded: "{rounded.xl}"
    padding: 24px

  bottom-sheet:
    backgroundColor: "{colors.surface-container-low}"
    rounded: "{rounded.xl}"
    padding: 24px

  # ── Snackbar ──────────────────────────────────────────────────────
  snackbar:
    backgroundColor: "{colors.inverse-surface}"
    textColor: "{colors.inverse-on-surface}"
    typography: "{typography.body-md}"
    rounded: "{rounded.xs}"
    padding: 16px

  # ── Divider ───────────────────────────────────────────────────────
  divider:
    backgroundColor: "{colors.outline-variant}"
    height: 1px
---

# TechZone AI Design System

## Overview

TechZone AI is a premium technology e-commerce experience that balances **consumer excitement** with **operational clarity**. The design language follows Material Design 3 principles adapted for two distinct user journeys:

- **Customer App**: A vibrant, product-forward storefront that makes browsing technology devices feel aspirational and effortless. The UI prioritizes visual merchandising, quick product discovery, and a frictionless purchase flow.
- **Admin Panel**: A data-dense management console that surfaces operational metrics, inventory status, and order pipelines at a glance. The layout favors scannability and efficiency over ornamentation.

The brand personality is **confident, modern, and energetic** — the kind of store where enthusiasts trust the curation and casual buyers feel guided. The primary orange acts as a directional spotlight: it says _"act here"_ and nothing else. Everything around it stays neutral and disciplined so the products themselves remain the visual heroes.

## Colors

The palette is derived from a Material Design 3 tonal system seeded from a vibrant "Tech Orange." Every surface, text, and interactive state maps to a role in the M3 color scheme, ensuring automatic dark-mode adaptability and WCAG accessibility.

### Core Palettes

- **Primary — Tech Orange (#E8611A):** The brand's signature. Used exclusively for primary CTAs, active navigation indicators, and price highlights. Its warmth conveys energy and confidence without the urgency of red.
- **On-Primary (#FFFFFF):** Pure white text/icons on primary-colored surfaces.
- **Primary Container (#FFDBC9):** A soft peach tint used for active navigation pills, selected filter chips, and tonal backgrounds that need to reference the brand without shouting.
- **On-Primary Container (#341100):** Deep burnt umber for legible text on primary container surfaces.

### Supporting Palettes

- **Secondary — Warm Slate (#76574B):** A desaturated brown-gray derived from the orange seed. Used for secondary text, captions, and supporting UI elements. It harmonizes with the primary without competing.
- **Tertiary — Tech Teal (#006B5E):** A cool counterpoint to the warm primary. Reserved for success states, "in stock" indicators, verified badges, and secondary action buttons where orange would create visual confusion.
- **Error (#BA1A1A):** Standard M3 error red for destructive actions, form validation, and out-of-stock alerts.

### Neutral System

- **Surface (#FFFBFF):** The canvas. A barely-warm white that prevents the sterile feel of pure #FFFFFF while keeping product images color-accurate.
- **Surface Containers:** Five tonal steps (lowest → highest) provide layering without shadows. Use `surface-container-low` for cards, `surface-container-high` for chips and bottom sheets, and `surface-container` for the bottom navigation bar.
- **On-Surface (#201A17):** Near-black with a warm undertone for primary text. Never use pure #000000.
- **Outline (#85746B):** For borders on outlined text fields, cards, and dividers.
- **Outline Variant (#D7C2B8):** Subtle dividers and decorative separators.

### Extended Colors

- **Success (#2E7D32):** Order delivered, payment confirmed, in-stock badges.
- **Warning (#F9A825):** Low stock alerts, pending review states.
- **Info (#1565C0):** Informational banners, help tooltips.
- **Star Rating (#FFB300):** Dedicated amber for the 5-star rating display.
- **Badge Discount (#D32F2F):** Sale percentage badges overlaid on product images.

## Typography

The type system pairs two Google Fonts optimized for mobile readability at every scale.

### Font Pairing

- **Poppins** — Headlines, titles, and display text. Its geometric roundness carries the brand's modern, approachable personality. The semi-bold weight (600) is the workhorse for section headers and product names, creating a confident hierarchy without heaviness.
- **Inter** — Body, labels, and data. A purpose-built screen font with tall x-height and open apertures. It excels at small sizes (12–16px) where product specs, prices, and metadata must remain crisp on dense mobile layouts.

### Hierarchy Rules

1. **One headline per screen.** Each screen has a single `headline-sm` or `headline-md` to anchor context (e.g., "Shopping Cart", "Order Details"). Avoid stacking multiple headline sizes.
2. **Prices use `title-md`.** Product prices are always rendered in Poppins Semi-Bold at 16px in the primary orange color. This creates a consistent "price signal" across cards, detail pages, and cart items.
3. **Specs and metadata use `body-sm`.** Technical specifications (CPU, RAM, storage) are rendered in Inter Regular at 12px. Dense but legible.
4. **Buttons use `label-lg`.** All button text is Inter Medium 14px with 0.1px letter spacing for maximum tap-target legibility.

### Loading States

Use `body-md` in `on-surface-variant` color for placeholder text and shimmer-skeleton labels. Never show raw loading spinners without contextual text.

## Layout & Spacing

The spacing system is built on a **4px base unit** with a practical scale that covers micro-adjustments (4px) through section-level separation (48px).

### Mobile Grid

- **Columns:** Single-column for full-width content; 2-column grid for product listings.
- **Screen Padding:** 16px horizontal margins on all screens.
- **Card Gap:** 12px between product cards in the grid.
- **Section Gap:** 24px vertical spacing between distinct content sections (e.g., between "Categories" and "Popular Products" on the home screen).

### Content Rhythm

- **Inline spacing** (icon-to-text, avatar-to-name): `sm` (8px)
- **Intra-component padding** (inside cards, buttons): `md` (16px)
- **Between related items** (cart items, notification tiles): `md` (16px)
- **Between sections** (home screen sections): `lg` (24px) to `xl` (32px)
- **Screen top/bottom breathing room**: `xl` (32px)

### Fixed Dimensions

- **Bottom Navigation Bar:** 80px height — accommodating icon (24px) + label (16px) + active indicator pill.
- **App Bar:** 56px standard; 112px for medium/large collapsible bars on product detail.
- **Product Card Image:** 160px height within the card, using `BoxFit.cover`.
- **FAB:** 56px × 56px with 16px margin from screen edges.

## Elevation & Depth

Material Design 3 on mobile favors **tonal elevation** over shadow-based depth. This design system uses surface-container tonal steps as the primary depth mechanism.

### Elevation Levels

| Level | Usage | Surface Token | Shadow |
|-------|-------|---------------|--------|
| 0 | Page background | `surface` | None |
| 1 | Cards, bottom nav | `surface-container-low` / `surface-container` | None or 1dp ambient |
| 2 | Bottom sheets, modals | `surface-container-high` | 3dp for sheets |
| 3 | FAB, snackbars | `primary-container` / `inverse-surface` | 6dp for FAB |
| 4 | Dialogs | `surface-container-high` | 8dp for dialogs |

### Shadow Guidelines

- **Product cards:** No shadow in the default state. A subtle `0 1px 3px rgba(0,0,0,0.08)` shadow appears only when the card is pressed/long-pressed.
- **Bottom sheet:** `0 -2px 8px rgba(0,0,0,0.12)` — minimal, just enough to separate from content.
- **FAB:** `0 3px 8px rgba(0,0,0,0.15)` — the strongest shadow in the system, ensuring it floats above content.
- **Admin stat cards:** `0 1px 4px rgba(0,0,0,0.06)` — barely-there shadow for subtle card separation.

## Shapes

The shape language is **Rounded Modern** — soft enough to feel approachable, structured enough to feel professional.

### Shape Scale

| Token | Value | Usage |
|-------|-------|-------|
| `none` | 0px | Dividers, full-bleed images |
| `xs` | 4px | Text fields, snackbars, data table cells |
| `sm` | 8px | Chips, small buttons, quantity steppers |
| `md` | 12px | Cards (product, cart, order), image containers |
| `lg` | 16px | Admin stat cards, bottom sheets, dialogs |
| `xl` | 28px | Filled buttons, FABs, search bar |
| `full` | 9999px | Avatar circles, active nav pills, badges, status chips |

### Shape Rules

- **Buttons** are always `xl` (28px) — the M3 "fully rounded" style that communicates tappability.
- **Cards** are always `md` (12px) — enough softness to feel contained without looking like bubbles.
- **Product images** inside cards use the same `md` radius as the card itself, with `clipBehavior` to prevent bleed.
- **Filter chips** use `sm` (8px) for a compact, utilitarian feel.
- **Status badges** (order status, cart count) use `full` radius to create pills and circles.

## Components

### Buttons

Four button tiers follow M3's emphasis hierarchy:

1. **Filled** (`button-filled`): Primary orange background, white text. Used for the single most important action per screen: "Add to Cart," "Place Order," "Login." Maximum one filled button visible at any time.
2. **Tonal** (`button-tonal`): Peach container background, dark text. For important-but-secondary actions: "Buy Now" (when "Add to Cart" is the primary), "Apply Filters."
3. **Outlined** (`button-outlined`): Transparent with orange text and 1px outline. For neutral actions: "View All," "Continue Shopping."
4. **Text** (`button-text`): No background, orange text. For low-emphasis actions: "Skip," "Cancel," "Forgot Password."

All buttons are 48px tall (meeting the 48px minimum touch target) with `xl` corner radius. Horizontal padding is 24px. Buttons include a 200ms ease-in-out background color transition on press.

### Product Card

The product card is the most repeated element in the customer UI. It is designed for a 2-column grid layout.

**Structure (top to bottom):**
1. **Image container** (160px, `surface-container` background, `md` radius) — product photo with `BoxFit.cover`. Discount badge positioned top-left. Wishlist heart icon top-right.
2. **Content area** (16px padding) containing:
   - Product name (`title-sm`, `on-surface`, max 2 lines with ellipsis)
   - Brand name (`body-sm`, `on-surface-variant`, single line)
   - Star rating row (amber stars + rating number in `label-sm`)
   - Price (`title-md`, `primary` color, bold)

The card itself has no outer padding — the grid gap handles separation. Inner content padding is 12px horizontal, 8px vertical below the image.

### Search Bar

Persistent at the top of the product list screen. Uses `surface-container-high` for a recessed feel. Leading search icon in `on-surface-variant`. Trailing filter icon button to open the filter bottom sheet. Full `xl` radius creates a pill shape. 56px height.

### Bottom Navigation (Customer)

Five destinations: **Home**, **Categories**, **Cart**, **Notifications**, **Profile**.

- Bar background: `surface-container` for tonal separation from page content.
- Active item: Icon sits inside a `primary-container` pill (64px × 32px, `full` radius). Label below in `on-primary-container`.
- Inactive item: Icon and label in `on-surface-variant`.
- Cart icon includes a `badge-cart` overlay showing item count (error-red circle, white text).
- 80px total height with 12px top padding for the active indicator pill.

### Category Chips

Horizontal scrolling row of filter chips below the search bar. Each chip shows a category icon + name. Active chip uses `chip-filter-active` (primary-container background). Chips are 32px tall with `sm` radius and 16px horizontal padding.

### Cart Item Tile

Horizontal layout inside a `cart-item` container:
- Left: Product image (80×80px, `md` radius)
- Center: Name, brand, price stacked vertically
- Right: Quantity stepper (−/count/+) using `cart-item-quantity` style
- Swipe-to-delete reveals a red background with trash icon

### Order Status Chips

Five status-specific chip styles, each with a distinct background/text color combination for instant visual recognition. All use `full` radius, `label-md` typography, and 12px horizontal padding.

### Chat Interface

- **User bubble** (`chat-bubble-user`): Primary orange background, white text, aligned right, `lg` radius with bottom-right corner set to `xs` for the "tail" effect.
- **AI bubble** (`chat-bubble-ai`): `surface-container-high` background, `on-surface` text, aligned left, `lg` radius with bottom-left corner set to `xs`.
- **Typing indicator**: Three animated dots inside an AI-style bubble, pulsing in sequence with 300ms stagger.
- Input bar: Fixed at bottom, `surface-container-low` background, rounded text field with a primary-colored send button (circular, `full` radius).

### Admin Dashboard

The admin UI trades the consumer's visual flair for information density:

- **Stat Cards** (`admin-stat-card`): Row of 2 or 3 cards showing Total Users, Total Orders, Total Revenue. Each card has a 48px icon container (`admin-stat-card-icon`) using `primary-container` background, with the metric value in `headline-md` and the label in `body-sm`.
- **Data Tables** (`admin-data-table`): Full-width tables with a `surface-container` header row and alternating white/`surface-container-low` body rows. Sortable column headers. Row actions (edit/delete) as icon buttons on the trailing edge.
- **Management forms**: Use `input-outlined` fields for data entry, organized in a single-column layout with `lg` (24px) vertical spacing between fields.

### Dialogs & Sheets

- **Bottom Sheet** (`bottom-sheet`): Used for product filters, sort options, and quantity selection. `surface-container-low` background with `xl` radius (top corners only). 4px × 32px drag handle centered at top in `outline` color.
- **Dialog** (`dialog`): Used for delete confirmations, logout confirmation, and order status updates. `surface-container-high` background, `xl` radius, 24px padding. Title in `headline-sm`, body in `body-md`, actions aligned right.

### Snackbar

Anchored to bottom, above the bottom navigation bar. `inverse-surface` background for high contrast. `xs` radius. Includes an optional action button in `inverse-primary` color.

## Do's and Don'ts

- **Do** use primary orange only for the single most important action per screen. Every other interactive element should use tonal, outlined, or text styles.
- **Don't** use orange for backgrounds, large surfaces, or decorative elements. It is a directional color, not an atmospheric one.
- **Do** let product images breathe. Never crop product photos into circles or apply color overlays. Use `BoxFit.cover` inside a `md`-radius container.
- **Don't** mix outlined and filled cards on the same screen. Choose one card style per screen context.
- **Do** use the teal tertiary color for success/positive states. Never use green that hasn't been pulled from the `success` token.
- **Don't** stack more than two typography fonts on a single screen. Poppins for structure, Inter for content — no exceptions.
- **Do** maintain 48px minimum touch targets for all interactive elements, including icon buttons.
- **Don't** use shadows heavier than 8dp anywhere in the customer UI. The design relies on tonal elevation, not drop shadows.
- **Do** show contextual empty states with an illustration and a CTA. Never show a blank screen with just "No data."
- **Don't** use pure black (#000000) or pure white (#FFFFFF) for text or backgrounds. Always use the tokenized surface and on-surface values.
- **Do** apply 200ms ease-in-out transitions to all interactive color changes (button press, chip selection, nav switching).
- **Don't** auto-play animations or transitions that take longer than 400ms. Mobile users expect snappy responses.
