class RecentFile {
  final String? title, date, state;

  RecentFile({this.title, this.date, this.state});
}

List demoRecentFiles = [
  RecentFile(
    title: "Ventillator doesn't work",
    date: "01-03-2021",
    state: "Sent to company",
  ),
  RecentFile(
    title: "dialysis machine",
    date: "27-02-2021",
    state: "Solved",
  ),
  RecentFile(
    title: "Diffibrillator needs maintinance",
    date: "23-02-2021",
    state: "Contact mangment",
  ),
  RecentFile(
    title: "No oxygen for anathesia",
    date: "21-02-2021",
    state: "Solved",
  ),
  RecentFile(
    title: "Ventillator needs maintinance",
    date: "23-02-2021",
    state: "Requested",
  ),
  RecentFile(
    title: "Autoclave doesn't work",
    date: "25-02-2021",
    state: "Solved by Engineer",
  ),
  RecentFile(
    title: "X-ray isn't working",
    date: "25-02-2021",
    state: "Requested",
  ),
];
