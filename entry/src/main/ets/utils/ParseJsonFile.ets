export class CourseModel {
  chapter: string = ''
  words: wordsModel[] = []
}

class wordsModel {
  chinese: string = ''
  english: string = ''
  phonetic: string = ''
}