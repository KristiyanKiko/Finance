# VALERI FINANCE

Личен финансов дневник с онлайн съхранение чрез Cloudflare Pages Functions и D1.

## Cloudflare setup
1. В Cloudflare създай Pages project от GitHub repository `KristiyanKiko/Finance`.
2. Build command: остави празно; build output directory: `public`.
3. Създай D1 база `valeri-finance-db`.
4. В Pages → Settings → Bindings добави D1 database binding с variable name `DB`.
5. В D1 Console изпълни SQL от `migrations/0001_init.sql`.
6. Redeploy проекта.
7. Отвори сайта и натисни „Създай първия профил“. Използвай парола поне 10 знака. Регистрацията се затваря след създаването на първия профил.

Сайтът използва server-side password hashing и HTTP-only session cookies. Данните са в D1 и могат да се отварят от различни браузъри след вход.

## Важно
Съществуващите записи от стария сайт в Edge не се прехвърлят автоматично. Експортирай CSV от стария сайт и запази копие. Импортът на CSV трябва да се добави отделно, преди да мигрираш тези записи. Не качвай пароли или токени в GitHub.
