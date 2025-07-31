const lowercase = 'abcdefghijklmnopqrstuvwxyz';
const uppercase = lowercase.toLocaleUpperCase();

const rotateChar = (ch, offset) => {
  let index = lowercase.indexOf(ch);
  if (index > -1) {
    return lowercase[(index + offset) % 26];
  }
  index = uppercase.indexOf(ch);
  if (index > -1) {
    return uppercase[(index + offset) % 26];
  }
  return ch;
};

export default class RotationalCipher {
  static rotate(phrase, offset) {
    return [...phrase].map(ch => rotateChar(ch, offset)).join('');
  }
}
