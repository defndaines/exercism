export default function transform(dict) {
  const result = {};
  Object.entries(dict).forEach(([k, v]) => {
    [...v].forEach((val) => { result[val.toLocaleLowerCase()] = Number(k); });
  });
  return result;
}
