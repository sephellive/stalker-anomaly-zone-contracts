# Журнал изменений / Changelog

[Русский](#русский) · [English](#english)

## Русский

Формат основан на [Keep a Changelog](https://keepachangelog.com/ru/1.1.0/), версии следуют [Semantic Versioning](https://semver.org/lang/ru/).

## [2.2.0] — 2026-08-17

### Добавлено

- Общий сохраняемый контроллер тяжёлой обороны с прибытием на позицию, предупреждением, подкреплениями и провалом при оставлении рубежа.
- Фиксированные штурмовые группы для трёх оборонительных сценариев.
- Шесть групп или волн в каждой обороне; одновременно активны не более трёх для ограничения нагрузки.
- Два расчёта РПГ и гарантированные экзоскелетчики в атаке «Монолита».
- Автоматические проверки структуры оборонительных заданий и состава специальных групп.

### Изменено

- Все 24 задания переведены на повышенные требования и более тяжёлые цели: усилены засады, патрули, логова, поставки и научные маршруты.
- Оборона начинается только после прибытия игрока к указанному блокпосту.
- Существующие сохранения поддерживаются; уже закэшированное WTF задание использует старую механику до завершения или отмены.

## [2.1.0] — 2026-08-17

### Добавлено

- Два отдельных FOMOD-архива с русским и английским интерфейсом установщика.
- Полная английская версия README, документации, каталога заданий и шаблонов Issues.
- Переключатель RU/EN в автономном HTML-каталоге.

### Изменено

- Автоматическая сборка теперь выпускает RU и EN архивы из одного набора исходников.
- Общие метаданные FOMOD и публичная документация стали двуязычными.

## [2.0.0] — 2026-08-17

### Добавлено

- 24 повторяемых задания в пяти тематических паках.
- Штурмы реальных гарнизонов с поиском документов.
- Оборона Ростока от мутантов, бандитов и «Монолита».
- Экспедиции в X-16 и X-18, поиск артефактов и биологических образцов.
- Полевая разведка, снабжение, поиск курьера и зачистка логов.
- FOMOD с выбором паков и варианта экономики.
- Русская и английская локализации.
- Локальная HTML-документация.

### Изменено

- Денежные награды рекомендуемого пресета снижены на 25%.
- Добавлены глобальные и пакетные лимиты, кулдауны и ротация предложений.
- Сохранены идентификаторы ранних патрульных заданий для совместимости с сохранениями.

### Исправлено

- Защитные волны корректно очищаются после отказа.
- Штурм не предлагается, если целевая база не занята подходящим вражеским гарнизоном.

---

## English

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and versions follow [Semantic Versioning](https://semver.org/).

## [2.2.0] — 2026-08-17

### Added

- A shared persistent heavy-defense controller with staged arrival, quest-giver warnings, reinforcements and failure when the line is deserted.
- Fixed assault squads for all three defense scenarios.
- Six groups or waves in every defense, with no more than three active at once to limit simulation load.
- Two RPG teams and guaranteed exoskeleton troops in the Monolith assault.
- Automated validation of defense structure and special squad composition.

### Changed

- All 24 quests now use higher requirements and heavier objectives: ambushes, patrols, nests, deliveries and research routes were reinforced.
- A defense starts only after the player reaches its designated checkpoint.
- Existing saves remain supported; a quest already cached by WTF keeps its old mechanics until completion or cancellation.

## [2.1.0] — 2026-08-17

### Added

- Two separate FOMOD archives with Russian and English installer interfaces.
- Complete English versions of the README, documentation, quest catalog and Issue templates.
- A RU/EN switch in the offline HTML catalog.

### Changed

- Automated releases now build RU and EN archives from the same source set.
- Shared FOMOD metadata and public documentation are now bilingual.

## [2.0.0] — 2026-08-17

### Added

- 24 repeatable quests in five thematic packs.
- Assaults against active garrisons with document recovery.
- Rostok defense scenarios involving mutants, bandits and Monolith.
- Expeditions to X-16 and X-18, artifact research and biological samples.
- Route surveys, supplies, courier recovery and mutant-nest cleanup.
- A FOMOD installer with selectable packs and economy presets.
- Russian and English in-game localizations.
- Offline HTML documentation.

### Changed

- Recommended monetary rewards reduced by 25%.
- Added global and per-pack limits, cooldowns and offer rotation.
- Preserved early patrol quest identifiers for save compatibility.

### Fixed

- Defense waves are removed correctly after a quest is abandoned.
- Assaults are not offered unless a suitable hostile garrison occupies the target base.
