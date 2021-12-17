/**
 * An implementation of the two-fer Exercism TypeScript challenge.
 *
 * @param name The optional name to include in the sentence.
 * @returns The sentence with the name or ‘you’ by default.
 */
export function twoFer(name?: string): string {
  return `One for ${name ? name : "you"}, one for me.`;
  // return `One for ${name || "you"}, one for me.`;
  // return `One for ${name   "you"}, one for me.`;
}
