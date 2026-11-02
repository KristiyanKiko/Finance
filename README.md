# VALERI FINANCE

Личен финансов дневник с онлайн съхранение чрез Cloudflare Pages Functions и D1.

## Cloudflare setup
1. В Cloudflare създай Pages project от GitHub repository `KristiyanKiko/Finance`.
2. Build command: остави празно; build output directory: `public`.
3. Създай D1 база `valeri-finance-db`.
4. В Pages → Settings → Bindings добави D1 database binding с variable name `DB`.
5. В D1 Console изпълни SQL от `migrations/0001_init.sql`.
6. Redeploy проекта.
7. В Pages → Settings → Variables and Secrets добави secret с име `BOOTSTRAP_SECRET` и стойност, която ти измислиш (поне 32 случайни знака). Redeploy проекта.\n8. Отвори сайта, попълни потребител, парола (поне 10 знака) и същия `BOOTSTRAP_SECRET`, след което натисни „Създай първия профил“. Регистрацията се затваря след създаването на първия профил. Кодът за първоначална регистрация остава само в настройките на Cloudflare и не се качва в GitHub.\n9. За прехвърляне на старите движения: от стария сайт в Edge направи „Експорт CSV“, после в новия сайт влез и използвай „Импорт CSV“. Импортът добавя записите към онлайн историята, без да изтрива вече наличните.

Сайтът използва server-side password hashing и HTTP-only session cookies. Данните са в D1 и могат да се отварят от различни браузъри след вход.

## Важно
Съществуващите записи от стария сайт в Edge не се прехвърлят автоматично. Експортирай CSV от стария сайт и запази копие. Новият сайт включва CSV импорт за стария формат на VALERI FINANCE. Не качвай пароли или токени в GitHub.
