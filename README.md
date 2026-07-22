# MOZa Ambtenarenportaal — NLDD experiment

Een prototype van een **ambtenarenportaal**: de overheidskant van
[MijnOverheid Zakelijk (MOZa)](https://www.mijnoverheidzakelijk.nl/). Waar de
[MOZa-proeftuin](https://proef.moza.rijksapp.dev/) ondernemers één omgeving geeft
voor berichten, notificaties, taken, zaken en machtigingen, biedt dit portaal de
behandelaar (ambtenaar) de spiegelkant: diezelfde stromen *behandelen*.

## Uitgangspunten

- **Design system:** het echte [`@nldd/design-system`](https://github.com/MinBZK/storybook)
  (v0.8.60), geladen vanaf de esm.sh CDN. Alle UI is opgebouwd uit `nldd-*`
  webcomponents — geen eigen component-styling, alleen wat layout-lijm
  (grid/flex/hoogte). Zie [`index.html`](index.html).
- **Functioneel hergebruik van MOZa:** dezelfde kernservices als de proeftuin,
  vanuit het perspectief van de behandelaar.

## Functionaliteit (secties)

| Sectie | MOZa-tegenhanger | Wat de ambtenaar doet |
|---|---|---|
| Dashboard | overzicht | KPI's: openstaande taken, nieuwe berichten, machtigingen, zaken + recente activiteit |
| Taken | Takenlijst | acties oppakken, met prioriteit/vervaldatum/status |
| Berichten | Berichtenservice | inkomende vragen van ondernemers lezen en beantwoorden |
| Zaken | Zakenlijst | lopende dossiers volgen en bijwerken |
| Machtigingen | Machtigingen | aanvragen (ondernemer → gemachtigde) beoordelen: goedkeuren/afwijzen |
| Notificaties | Notificatieservice | verzonden meldingen inzien, nieuwe versturen |
| Instellingen | Profielservice | notificatievoorkeuren en behandelaarsprofiel |

## Gebruikte NLDD-componenten

Shell: `nldd-top-navigation-bar`, `nldd-app-view`, `nldd-navigation-split-view`,
`nldd-page`, `nldd-top-title-bar`, `nldd-simple-section`.
Inhoud: `nldd-card`, `nldd-container`, `nldd-title`, `nldd-rich-text`,
`nldd-banner`, `nldd-tag`, `nldd-badge`, `nldd-table` (+ `nldd-table-row` /
`nldd-text-cell` / `nldd-cell`), `nldd-list` (+ `nldd-list-item` /
`nldd-icon-cell` / `nldd-spacer-cell`), `nldd-button`, `nldd-switch-field`,
`nldd-text-field`, `nldd-icon`.

## Draaien

Open `index.html` in een browser. De pagina haalt CSS én componenten op via de
esm.sh CDN, dus **een internetverbinding is nodig**. Navigatie tussen secties en
de demo-acties (machtiging goedkeuren/afwijzen) draaien op een klein stukje
vanilla JavaScript onderaan het bestand.

## API-conventies (geverifieerd tegen de bron)

- `nldd-tag`, `nldd-button`, `nldd-top-title-bar` → label via **`text`-attribuut**.
- `nldd-button` → icoon via **`start-icon`** / `end-icon`; varianten o.a.
  `primary`, `secondary`, `destructive`.
- `nldd-title` → `size` is **1–6**, titel in een `<h*>`-element, ondertitel in
  `<p slot="subtitle">`.
- `nldd-banner` → kleur via **`variant`** (`neutral|accent|success|warning|critical`),
  tekst via `text` + `supporting-text`.
- Formulieren → label op een omhullende **`nldd-form-field`**; bij `nldd-text-field`
  wordt de waarde als `.value`-property gezet (zie het script onderaan).
- Iconen zijn geverifieerd tegen de NLDD icon-registry (o.a. `house`, `check-list`,
  `envelope`, `folder`, `key`, `bell`, `gear`, `magnifier`, `person`,
  `arrow-right-out-bucket`, `plus`, `dismiss`, `file-box`, `paper-plane`,
  `message-rectangle-text`, `check-mark`).

## Feature flags (demo)

Experimentele functionaliteit staat achter feature flags: klik in de footer op
**Flags** en zet een flag aan of uit. De keuze wordt per browser bewaard
(localStorage `moza-flags`); standaard staan alle flags uit.

| Flag | Wat er aan gaat |
|---|---|
| Berichten | berichten samenstellen en versturen binnen de notificatiedienst |
| Kanaalvoorkeur | kanaalvoorkeur van een ondernemer opzoeken en aanpassen (profieldienst) |
| Certificaat-authenticatie | de API keys-pagina's tonen **certificaten (mTLS)** in plaats van API keys: aanvragen met een CSR (nooit een private key), profiel/template i.p.v. losse X.509-velden, mock-uitgifte onder PKIoverheid, beheer met expiry-waarschuwing, vernieuwen en intrekken |

## Let op

- Dit is een proeftuin/prototype. De data is **fictief**; gebruik geen echte
  persoons- of bedrijfsgegevens (net als de MOZa-proeftuin geen echte
  DigiD/eHerkenning heeft).
- De pagina is later eenvoudig verder te bouwen met de **`nldd` Claude Code
  plugin** (marketplace `nldd-plugins`), die de componentkennis levert.
