# Участие в разработке / Contributing

[Русский](#русский) · [English](#english)

## Русский

Спасибо за сообщения об ошибках, предложения заданий и помощь с балансом.

## Перед изменением

1. Создайте Issue с описанием сценария и ожидаемого поведения.
2. Не переименовывайте существующие JSON-файлы заданий: их имена используются как стабильные идентификаторы в сохранениях WTF.
3. Новые задания помещайте в логически подходящий FOMOD-пак.
4. Добавляйте одинаковый набор строк для `rus` и `eng`.
5. Проверяйте отказ, завершение, повторную выдачу и загрузку существующего сохранения.

## Проверка

```powershell
pwsh ./tools/validate.ps1
```

Проверка разбирает JSON и XML, ищет дубли идентификаторов, сверяет локализации, кредиты и ссылки FOMOD на каталоги.

## Баланс

- Не добавляйте крупную награду только за обычный отряд.
- Учитывайте общие лимиты паков и время повторной выдачи.
- Для создаваемых отрядов и предметов обязательно добавляйте очистку при провале.
- Задание должно быть полезно нескольким группировкам либо иметь понятное сюжетное ограничение.

Pull Request должен кратко описывать влияние на существующие сохранения.

---

## English

Bug reports, quest proposals and balancing feedback are welcome.

### Before making changes

1. Open an Issue describing the scenario and expected behavior.
2. Do not rename existing quest JSON files: WTF uses their names as stable identifiers in saves.
3. Place new quests in the appropriate FOMOD pack.
4. Add the same string-id set to both `rus` and `eng` localizations.
5. Test abandonment, completion, repeat availability and loading an existing save.

### Validation

```powershell
pwsh ./tools/validate.ps1
```

The validator parses JSON and XML, detects duplicate identifiers, compares localizations, verifies credits and checks FOMOD source-directory references.

### Balance

- Do not award a large payment for eliminating a routine squad.
- Account for shared pack limits and repeat timers.
- Every spawned squad or item must be cleaned up when its quest fails.
- A quest should support multiple factions or clearly document its story restriction.

Every Pull Request must briefly describe its effect on existing saves.
