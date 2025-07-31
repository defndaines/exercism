export default function transpose(arr) {
  const len = Math.max.apply(null, arr.map(row => row.length));
  let resp = Array.from({ length: len }, () => []);
  Array.from({ length: len }, (_, i) => i)
    .forEach((i) => {
      arr.forEach(row => resp[i].push(row[i] || ' '));
    });
  resp = resp.map(row => row.join(''));

  // Trim the backhair for the edge case
  if (resp.length > 0) {
    resp[resp.length - 1] = resp[resp.length - 1].trimEnd();
  }

  return resp;
}
