//
// Some shorter aliases are nice to have.
//
export const log: Console["log"] = console.log.bind(console);
export const info: Console["info"] = console.info.bind(console);
export const warn: Console["warn"] = console.warn.bind(console);
export const err: Console["error"] = console.error.bind(console);
