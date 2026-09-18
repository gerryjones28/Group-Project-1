
## Setup: Your Personal API Key

The College Scorecard API requires a personal key. **Each group member needs their own.** Do not share keys. This takes about 5 minutes.

If you skip this step, every API call in the project will fail with `Error: Missing API key`.

---

## Step 1 — Get Your Free API Key

1. Go to https://collegescorecard.ed.gov/data/api-documentation/

2. Fill in the form

3. Click **Sign Up**.

4. Check your email for a message from `api.data.gov`. It will contain your API key — a long string of letters and numbers like `aBcDeFgHiJkLmNoPqRsTuVwXyZ1234567890`.

5. **Copy the key.** You'll use it in the next step.

If you don't see the email, check spam. If it's not there after 10 minutes, sign up again with a different email.

---

## Step 2 — Save Your Key to `.Renviron`

Your key goes in a special hidden file called `.Renviron` that lives in your **home folder**, not in the project. That way it never gets committed to GitHub.

### On Mac

1. Open **Terminal** (Spotlight: `Cmd + Space`, type "Terminal").
2. Type this and press Enter:
   ```bash
   nano ~/.Renviron
   ```
3. Type or paste this line, replacing the placeholder with your actual key:
   ```
   DATAGOV_API_KEY=yourkeygoeshere
   ```
   No quotes. No spaces around the `=`.
4. Save with `Ctrl + O`, press `Enter`, then exit with `Ctrl + X`.

### On Windows

1. Open **Notepad** (Start menu → type "Notepad").
2. Type or paste this line, replacing the placeholder with your actual key:
   ```
   DATAGOV_API_KEY=yourkeygoeshere
   ```
   No quotes. No spaces around the `=`.
3. Go to **File → Save As**.
4. Navigate to `C:\Users\YourName\` (your user folder).
5. In the **File name** box, type: `.Renviron`
6. Change **Save as type** to **All Files**.
7. Click **Save**.
8. If Windows warns about the dot at the start, click **Yes**.

---

## Step 3 — Restart RStudio

`.Renviron` is only read when RStudio starts. If RStudio is already open, it won't see the new file.

1. Quit RStudio completely:
   - **Mac:** `Cmd + Q`
   - **Windows:** File → Quit Session
2. Reopen RStudio.

---

## Step 4 — Verify It Works

Open RStudio. In the **Console** (bottom-left pane), run this:

```r
Sys.getenv("DATAGOV_API_KEY")
```

**Expected result:** your API key printed back, like:

```
[1] "aBcDeFgHiJkLmNoPqRsTuVwXyZ1234567890"
```

**If you see `[1] ""` (two empty quotes):** something is wrong. Go back and check:

- The file is at `~/.Renviron` on Mac, or `C:\Users\YourName\.Renviron` on Windows
- The file is named exactly `.Renviron` — not `.Renviron.txt`, not `Renviron`
- The line inside is exactly `DATAGOV_API_KEY=yourkey` with no quotes, no spaces
- You fully quit and reopened RStudio after saving

Fix it and try again.

---

## Step 5 — Test the API

Once Step 4 works, run this in the Console:

```r
library(rscorecard)

sc_init() |>
  sc_filter(stabbr == "FL") |>
  sc_select(unitid, instnm) |>
  sc_get()
```

**Expected result:** a data frame with two columns (`unitid`, `instnm`) and several hundred rows — the Florida colleges in the database.

**If you get `Error: Missing API key`:** Step 4 didn't actually work. Go back and re-verify.

**If you get `Error in library(rscorecard)`:** install the package first:
```r
install.packages("rscorecard")
```

**If you get `403 Forbidden`:** your key is valid but incorrect — re-check for typos.

---

## That's It

Once Step 5 returns a data frame, you're fully set up. You can now run any script in the project.


---

## Rules

- **Never** put your API key in a `.R` script.
- **Never** put your key in this GitHub repo.
- **Never** share your key with the group. Everyone gets their own.
- If you accidentally expose your key, revoke it at https://api.data.gov and generate a new one.

