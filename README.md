# lupdate-action

Runs `lupdate` to update Qt translation sources.

Your project must have a `sources.json` file, usually located under the `.tx` directory.
This file contains a list of objects with the following keys:
  * `directory`: sources directory
  * `output_path`: path to the source translation to create

Here's an example:

```json
[{"directory": "src", "output_path": "translations/app/liri-text.ts"}]
```

## Usage

This action is usually called in a `schedule` workflow like this:

```yaml
name: Translations Sync

on:
  schedule:
    - cron: '0 15 * * 0'

jobs:
  update-translations:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Run lupdate
        uses: liri-infra/lupdate-action@master
      - name: Push sources and pull translations
        uses: liri-infra/transifex-action@master
        with:
            tx_token: ${{ secrets.TX_TOKEN }}
            ssh_key: ${{ secrets.CI_SSH_KEY }}
            push_sources: true
            pull_translations: true
```

The example checks out the project, configures git to push with a ssh key,
then update `.ts` files, push them to Transifex and pull back the
translations refreshed with the new sources.
