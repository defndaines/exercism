export const hey = (message) => {
  if (message === message.toUpperCase() && /[A-Z]/.test(message)) {
    if (/\?$/.test(message)) {
      return 'Calm down, I know what I\'m doing!';
    }
    return 'Whoa, chill out!';
  }
  if (/\?$/.test(message.trim())) {
    return 'Sure.';
  }
  if (/^\s*$/.test(message)) {
    return 'Fine. Be that way!';
  }
  return 'Whatever.';
};
