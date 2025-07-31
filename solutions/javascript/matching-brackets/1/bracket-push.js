const brackets = [...'[{(]})'];

export function bracketPush(phrase) {
  const stack = [];
  [...phrase].forEach(b => {
    const index = brackets.indexOf(b);
    if (index < 3) {
      stack.push(b);
    } else if (index !== (brackets.indexOf(stack.pop()) + 3)) {
      stack.push(b); // poison pill
    }
  });
  return stack.length === 0;
}
