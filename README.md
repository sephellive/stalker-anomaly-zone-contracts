# Контракты Зоны / Zone Contracts

[![Build validation / Проверка сборки](https://github.com/sephellive/stalker-anomaly-zone-contracts/actions/workflows/validate.yml/badge.svg)](https://github.com/sephellive/stalker-anomaly-zone-contracts/actions/workflows/validate.yml)
[![MIT License / Лицензия MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

[Русский](#русский) · [English](#english)

## Русский

Модульный набор повторяемых заданий для **S.T.A.L.K.E.R. GAMMA / Anomaly** на базе **Weird Tasks Framework 4.2.3**. Аддон добавляет боевые контракты, штурмы действующих баз, оборону Ростока, научные экспедиции и полевую работу. Он рассчитан на существующие сохранения и более медленную, тяжёлую прогрессию.

Текущая версия: **2.2.0**. В составе 24 задания и два FOMOD-установщика — с русским и английским интерфейсом. Оба архива содержат обе игровые локализации и отличаются только языком установщика.

## Возможности

- задания учитывают реально существующие отряды и состояние базы;
- штурмы повторяются после восстановления гарнизона и завершения кулдауна;
- каждая оборона начинается только после прибытия игрока на рубеж и предупреждения квестодателя;
- каждая оборона состоит из шести тяжёлых групп или волн; одновременно симулируются не более трёх;
- в прорыве «Монолита» участвуют экзоскелетчики и два расчёта РПГ;
- оборонительные волны очищаются при отказе от задания или уходе с рубежа;
- повышенные ранговые требования, усиленные засады, снабжение и исследовательские маршруты рассчитаны на подготовленного персонажа;
- глобальный лимит — не более пяти активных заданий аддона;
- однотипные задания ограничены отдельными лимитами и общими кулдаунами;
- предложения ротируются, поэтому один NPC не выдаёт сразу весь список;
- русская и английская локализации;
- два варианта денежного баланса;
- установка отдельных тематических паков через FOMOD.

## Паки заданий

| Пак | Заданий | Содержание |
| --- | ---: | --- |
| Патрульные контракты | 8 | Блокпосты, засады, колонны, ветераны и дальние рейды |
| Штурмовые операции | 4 | Агропром, Тёмная долина, Армейские склады и Мёртвый город |
| Оборона рубежей | 3 | Мутанты, бандиты и прорыв «Монолита» к Ростоку |
| Научные экспедиции | 5 | X-16, X-18, редкие артефакты, биология и замеры аномалий |
| Полевая работа | 4 | Разведка, снабжение, поиск курьера и зачистка логова |

Полный интерактивный каталог находится в [`00 Core/docs/index.html`](00%20Core/docs/index.html).

## Требования

- S.T.A.L.K.E.R. Anomaly с актуальной GAMMA;
- Weird Tasks Framework 4.2.3;
- Mod Organizer 2 рекомендуется для установки и обновления.

## Установка

1. Скачайте `FOMOD.RU.zip` или `FOMOD.EN.zip` из раздела [Releases](https://github.com/sephellive/stalker-anomaly-zone-contracts/releases).
2. Установите архив через Mod Organizer 2.
3. Выберите один вариант экономики и нужные паки заданий.
4. Разместите аддон после Weird Tasks Framework и его базовых наборов заданий.
5. Не отключайте установленный пак, пока задание из него активно.

Новая игра не требуется. Задания, уже сохранённые WTF до обновления, сохранят старую механику, награду и параметры до сдачи или отмены. Чтобы получить новую постановку обороны, завершите или отмените уже активную старую версию и возьмите контракт повторно после кулдауна.

## Защита от фарма

- максимум 5 активных заданий аддона суммарно;
- максимум 1 активный штурм и 1 оборона;
- максимум 2 задания каждого из остальных паков;
- общие кулдауны паков от 8 игровых часов до 3 игровых суток;
- дополнительные таймеры повторения отдельных заданий;
- ежедневная ротация предложений у каждого квестодателя.

## Разработка и выпуск обновлений

```powershell
pwsh ./tools/validate.ps1
pwsh ./tools/build-release.ps1 -Version 2.2.0
```

Два готовых архива появятся в `dist/`. При публикации тега `v*` GitHub Actions автоматически проверит проект, соберёт RU/EN FOMOD и создаст GitHub Release. Инструкция для ModDB находится в [`docs/MODDB.md`](docs/MODDB.md).

Идентификаторы существующих JSON-заданий нельзя переименовывать без миграции: WTF сохраняет их в текущем прохождении.

## Использование искусственного интеллекта

Для генерации идей заданий и первоначальных вариантов JSON-конфигураций использовались инструменты искусственного интеллекта. Итоговые сценарии, баланс, ограничения, локализация, интеграция с WTF и проверки проходили ручную редактуру. Сообщения об ошибках и предложения по балансу приветствуются в Issues.

## Авторы

- Sephellive
- [Igigog](https://www.moddb.com/members/igigog)
- folk
- Lasse Scheyde

## Лицензия

Исходный код и оригинальные файлы этого репозитория распространяются по лицензии [MIT](LICENSE). S.T.A.L.K.E.R., Anomaly, GAMMA и Weird Tasks Framework являются отдельными проектами и не входят в состав данной лицензии.

---

## English

A modular set of repeatable quests for **S.T.A.L.K.E.R. GAMMA / Anomaly**, built for **Weird Tasks Framework 4.2.3**. The addon adds combat contracts, assaults against active bases, Rostok defense scenarios, scientific expeditions and field work. It is designed for existing saves and a slower, harsher progression curve.

Current version: **2.2.0**. It contains 24 quests and two FOMOD installers with Russian or English installer interfaces. Both archives include both in-game localizations; only the installer language differs.

### Features

- quests account for existing squads and the current state of a base;
- assaults become available again after the garrison repopulates and the cooldown expires;
- every defense starts only after the player reaches the line and receives the quest giver's warning;
- every defense contains six heavy groups or waves, with no more than three simulated at once;
- the Monolith breakthrough includes exoskeleton troops and two RPG teams;
- spawned defense waves are removed if the quest is abandoned or the line is deserted;
- higher rank gates, reinforced ambushes, larger supply orders and longer research routes target a prepared character;
- no more than five addon quests may be active at once;
- similar quests use separate active limits and shared cooldowns;
- offers rotate, preventing one NPC from exposing the complete list at once;
- full Russian and English in-game localizations;
- two monetary balance presets;
- optional thematic packs selected through FOMOD.

### Quest packs

| Pack | Quests | Content |
| --- | ---: | --- |
| Patrol Contracts | 8 | Roadblocks, ambushes, columns, veterans and deep raids |
| Assault Operations | 4 | Agroprom, Dark Valley, Army Warehouses and Dead City |
| Defend the Line | 3 | Mutants, bandits and a Monolith breakthrough toward Rostok |
| Scientific Expeditions | 5 | X-16, X-18, rare artifacts, biology and anomaly measurements |
| Field Work | 4 | Route surveys, supplies, a missing courier and a mutant nest |

The complete interactive catalog is available at [`00 Core/docs/index.html`](00%20Core/docs/index.html).

### Requirements

- an up-to-date S.T.A.L.K.E.R. GAMMA / Anomaly installation;
- Weird Tasks Framework 4.2.3;
- Mod Organizer 2 is recommended for installation and updates.

### Installation

1. Download either `FOMOD.RU.zip` or `FOMOD.EN.zip` from [Releases](https://github.com/sephellive/stalker-anomaly-zone-contracts/releases).
2. Install the archive through Mod Organizer 2.
3. Select one economy preset and the quest packs you want.
4. Place the addon after Weird Tasks Framework and its base quest packs.
5. Do not disable an installed pack while one of its quests is active.

A new game is not required. Quests already cached by WTF before the update retain their old mechanics, rewards and parameters until completion or cancellation. To receive a rebuilt defense, finish or cancel its old active version and accept it again after the cooldown.

### Anti-farming rules

- no more than 5 active addon quests in total;
- no more than 1 active assault and 1 active defense;
- no more than 2 active quests from each remaining pack;
- shared pack cooldowns from 8 in-game hours to 3 in-game days;
- additional repeat timers for individual quests;
- daily offer rotation per quest giver.

### Development and releases

```powershell
pwsh ./tools/validate.ps1
pwsh ./tools/build-release.ps1 -Version 2.2.0
```

Both archives are generated in `dist/`. Publishing a `v*` tag makes GitHub Actions validate the project, build the RU and EN FOMOD archives and create a GitHub Release. See [`docs/MODDB.md`](docs/MODDB.md) for the ModDB publishing checklist.

Do not rename existing JSON quest files without a migration: WTF stores their names as stable identifiers in active saves.

### Use of artificial intelligence

Artificial-intelligence tools were used to generate quest ideas and initial JSON configuration drafts. The final scenarios, balance, restrictions, localization, WTF integration and validation received manual review and editing. Bug reports and balancing feedback are welcome in Issues.

### Credits

- Sephellive
- [Igigog](https://www.moddb.com/members/igigog)
- folk
- Lasse Scheyde

### License

The source code and original files in this repository are distributed under the [MIT License](LICENSE). S.T.A.L.K.E.R., Anomaly, GAMMA and Weird Tasks Framework are separate projects and are not covered by this license.
