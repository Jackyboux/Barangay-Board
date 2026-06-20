# Barangay Board — Design Document v1

A neighborhood bulletin board app for Filipino communities. Posts are organized by barangay with no algorithm — just your community.

---

## Screens

### 1. Splash Screen
- App logo (white card, blue board icon with orange `+`) centered on a solid primary-blue background
- App name: **Barangay Board** (Nunito, extrabold)
- Tagline: *"Your neighborhood, connected"*
- Animated loading dots at the bottom
- Auto-navigates to Login after 2 seconds

### 2. Login Screen
- Blue header band with logo + app name + welcome copy
- Email or phone number input
- Password input with show/hide toggle
- Primary **Log in** button (full width, blue)
- "Forgot password?" text link
- Divider: *"Don't have an account?"*
- **Sign up** outlined button navigating to Register

### 3. Register Screen
- Blue header with back arrow + "Create account" title
- Fields: Full name, Email/phone, Password (with toggle), Confirm password
- Barangay/location dropdown (12 barangay options)
- Primary **Sign up** button
- "Already have an account? Log in" link

### 4. Home / Feed Screen
- **Header**: App name + current barangay with pin icon; Notification bell (with orange dot badge) + Profile icon
- **Search bar**: Tappable field inside the blue header band → navigates to Search screen
- **Category filter tabs** (horizontal scroll): All · Announcements · Lost & Found · Jobs · Safety · For Sale
- **Feed**: Scrollable list of PostCards
- **FAB**: Orange floating `+` button (bottom-right) → navigates to Create Post
- **Bottom navigation bar** (persistent)

### 5. Create Post Screen
- White header bar: back arrow (left) + "New Post" title + **Post** button (right, disabled until fields filled)
- **Category chips**: Announcement · Lost & Found · Jobs · Safety · For Sale (color-coded on select)
- Title input (single line)
- Details textarea (multi-line, 5 rows)
- "Add a photo" dashed button (camera icon)
- Location row (defaults to user's barangay, with Change link)
- **Post to Community** primary button at bottom

### 6. Post Detail Screen
- Header color matches category (red for Safety, blue otherwise)
- Full author info: avatar, name, barangay, time ago
- Category badge
- Full title (Nunito extrabold) + full body text
- Optional image (full width, rounded corners)
- Like + Comment count action row
- **Comments section**: avatar + bubble layout, author + timestamp per comment
- **Pinned comment input** at bottom with Send button

### 7. Search Screen
- Blue header with back arrow + inline search input (white, autofocused)
- **Category filter chips** below header (color-coded, toggle active state)
- **Empty state** (no query): Recent searches list with search icon
- **Results state**: match count label + PostCards
- **No results state**: icon + "No results found" message

### 8. Notifications / Alerts Screen
- Blue header: "Notifications" title + "Mark all read" link
- Safety alerts visually separated at top (red-tinted row background + red ALERT badge)
- Each notification: colored icon bubble (type-specific) + message text + timestamp
- Types: Safety (red triangle), Announcement (blue megaphone), Like (pink heart), Comment (green bubble)
- Tap navigates to the related post

### 9. Profile Screen
- Blue header: large avatar (initials), name, barangay, member-since date; Logout icon (top right)
- **Stats row**: Posts · Likes received · Comments (each in a frosted white-on-blue tile)
- **Edit Profile** + Settings icon buttons
- **Tabs**: My Posts / Saved Posts
- PostCard list per tab; empty state for Saved if none

### 10. Edit Profile Screen
- Blue header: back arrow (left) + **Save** button (orange, right)
- Avatar with orange camera badge (tap to change photo)
- Fields: Full name, Email/phone, Barangay dropdown, Short bio (optional textarea)
- **Save Changes** primary button at bottom

### 11. Bottom Navigation (App Shell)
Persistent on Home, Nearby, Alerts, Profile:

| Tab | Icon | Screen |
|-----|------|--------|
| Feed | Home | Main feed |
| Nearby | Map pin | Nearby posts list + map placeholder |
| Alerts | Bell (with count badge) | Notifications |
| Profile | User | Profile |

Active tab: bold icon stroke + small blue indicator line at bottom edge.

---

## Design Tokens

| Token | Value | Usage |
|-------|-------|-------|
| `--primary` | `#1565C0` | Header bars, primary buttons, active nav |
| `--accent` | `#F57C00` | FAB, Save button, avatar camera badge |
| `--background` | `#F4F6FB` | Page background |
| `--card` | `#ffffff` | Post cards, bottom nav, input sheets |
| `--muted` | `#EEF0F6` | Input backgrounds, tag backgrounds |
| `--muted-foreground` | `#6B7280` | Captions, timestamps, placeholders |
| `--destructive` | `#C62828` | Safety alert accents |
| `--border` | `rgba(0,0,0,0.08)` | Card borders, dividers |
| `--radius` | `0.75rem` | Default border radius |

---

## Category Badge Colors

| Category | Background | Text |
|----------|-----------|------|
| Announcements | `bg-blue-100` | `text-blue-700` |
| Lost & Found | `bg-amber-100` | `text-amber-700` |
| Jobs | `bg-green-100` | `text-green-700` |
| Safety | `bg-red-100` | `text-red-700` |
| For Sale | `bg-purple-100` | `text-purple-700` |

Safety posts additionally get a **solid red banner** at the top of the card.

---

## Typography

| Role | Font | Weight | Size |
|------|------|--------|------|
| App name, headings | Nunito | 800 (extrabold) | 1.2–1.5rem |
| Post titles | Nunito | 800 | 1.05rem |
| Body text, labels | Inter | 400–600 | 0.875–1rem |
| Captions, timestamps | Inter | 400 | 0.75–0.875rem |

---

## Post Card Anatomy

```
┌──────────────────────────────────────────┐
│ [⚠ Safety Alert banner — red, if Safety] │
├──────────────────────────────────────────┤
│  ┌──┐  Author Name          (bold, base) │
│  │AV│  2h ago · Brgy. Poblacion  (small) │
│  └──┘                                    │
│  [Category Badge]                        │
│                                          │
│  Post Title (Nunito extrabold, 1.05rem)  │
│  Body text truncated to 3 lines…         │
│                                          │
│  [Optional image, 192px tall]            │
│ ──────────────────────────────────────── │
│  ♥ 34   💬 8   [Share →]                 │
└──────────────────────────────────────────┘
```

---

## Navigation Flow

```
Splash ──► Login ──► Register
                │
                ▼
             Home (Feed)
              │  │  │
     Search ◄─┘  │  └─► Create Post
                 │
          Post Detail ◄─── (from any feed)
                 │
       ┌─────────┼──────────┐
       ▼         ▼          ▼
    Nearby    Alerts     Profile
                            │
                       Edit Profile
```

---

## Sample Content Used

| Post | Category | Author |
|------|----------|--------|
| Road Clearing Operations This Saturday | Announcements | Barangay Hall |
| Lost: Brown Labrador near Palengke | Lost & Found | Maria Santos |
| ALERT: Flooded road at Maharlika St. | Safety | Juan dela Cruz |
| Now Hiring: Service Crew (Part-time) | Jobs | Jollibee Poblacion |
| Ukay-Ukay Bundle — Kids Clothes | For Sale | Rosa Reyes |
| Free Medical Mission — June 25 | Announcements | Kapitan Reyes |

---

## Design Notes

- **Flat and lightweight** — no heavy gradients, no shadows heavier than `shadow-sm`
- **Safety always stands out** — red banner, red header, red notification rows; never buried
- **Large tap targets** — all interactive elements minimum 44×44px
- **Filipino-grounded copy** — real barangay names, Tagalog phrases in comments (`Salamat sa info!`), local context (palengke, ukay-ukay, MDRRMO)
- **Phone frame mock** at 390×844px (iPhone 14 proportions) with status bar simulation in-browser

---

*Generated: June 2026 · Barangay Board v1*
