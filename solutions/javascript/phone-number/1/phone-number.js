const validPhoneNumber = new RegExp(/\D*1?\D*([2-9]\d\d)\D*([2-9]\d\d)\D*(\d{4})\D*/g);

const normalize = (number) => {
  const digits = number.replace(validPhoneNumber, '$1$2$3');
  return (digits.length === 10) ? digits : null;
};

export default class PhoneNumber {
  constructor(number) {
    this.digits = normalize(number);
  }

  number() { return this.digits; }
}
