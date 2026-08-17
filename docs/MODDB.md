# Подготовка публикации на ModDB / ModDB publishing

[Русский](#русский) · [English](#english)

## Русский

## Файл

Соберите архив командой:

```powershell
pwsh ./tools/build-release.ps1 -Version 2.1.0
```

В ModDB загружаются `dist/Zone.Contracts.v2.1.0.FOMOD.RU.zip` и `dist/Zone.Contracts.v2.1.0.FOMOD.EN.zip`. Это те же артефакты, которые используются в GitHub Releases.

## Краткое описание

«Контракты Зоны» — модульный набор из 24 повторяемых заданий для S.T.A.L.K.E.R. GAMMA / Anomaly и Weird Tasks Framework 4.2.3. Включает патрули, штурмы действующих баз, оборону Ростока, научные экспедиции и полевую работу. FOMOD позволяет выбрать паки и вариант экономики. Поддерживает существующие сохранения.

## Требования

- актуальная GAMMA / Anomaly;
- Weird Tasks Framework 4.2.3;
- установка через MO2.

## Рекомендуемые изображения

1. Обложка из `00 Core/docs/assets/zone-contracts-hero.png`.
2. Страница выбора паков FOMOD.
3. Два-три игровых кадра: штурм базы, оборона Ростока, научное задание.
4. Скриншот каталога заданий.

## Перед публикацией

- выполнить `tools/validate.ps1`;
- протестировать загрузку существующего сохранения;
- завершить и отменить по одному заданию каждого пака;
- проверить свежий `xray_*.log`;
- обновить `CHANGELOG.md` и номер версии в `fomod/info.xml`;
- создать тег `vX.Y.Z` и приложить автоматически собранный ZIP.

---

## English

### Files

Build both archives with:

```powershell
pwsh ./tools/build-release.ps1 -Version 2.1.0
```

Upload `dist/Zone.Contracts.v2.1.0.FOMOD.RU.zip` and `dist/Zone.Contracts.v2.1.0.FOMOD.EN.zip` to ModDB. These are the same artifacts published by GitHub Releases.

### Short description

Zone Contracts is a modular set of 24 repeatable quests for S.T.A.L.K.E.R. GAMMA / Anomaly and Weird Tasks Framework 4.2.3. It includes patrols, assaults against active bases, Rostok defense scenarios, scientific expeditions and field work. FOMOD lets players select quest packs and an economy preset. Existing saves are supported.

### Requirements

- an up-to-date GAMMA / Anomaly installation;
- Weird Tasks Framework 4.2.3;
- installation through MO2.

### Recommended images

1. The cover from `00 Core/docs/assets/zone-contracts-hero.png`.
2. The FOMOD pack-selection screen in both languages.
3. Two or three gameplay shots: a base assault, Rostok defense and a science quest.
4. A screenshot of the bilingual quest catalog.

### Before publishing

- run `tools/validate.ps1`;
- test an existing save;
- complete and abandon one quest from every pack;
- inspect the latest `xray_*.log`;
- update `CHANGELOG.md` and the version in `fomod/info.xml`;
- create a `vX.Y.Z` tag and attach both automatically built archives.
