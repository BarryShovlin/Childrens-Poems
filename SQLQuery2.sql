--1 What grades are stored in the database?
SELECT COUNT(Grade.Id) GradeCount
FROM Grade;

--2 What emotions may be associated with a poem?
SELECT COUNT(Emotion.Id) EmotionCount
FROM Emotion;

--3 How many poems are in the database?
SELECT COUNT(Poem.Id) PoemCount
FROM Poem

--4 Sort authors alphabetically by name. What are the names of the top 76 authors?
SELECT TOP 76 a.Name as TopSeventySixAuthors
FROM Author a 
ORDER BY a.Name;

--5 Starting with the above query, add the grade of each of the authors.
SELECT TOP 76 a.name as TopSeventySixWithGrade, g.name
FROM Author a LEFT JOIN Grade g ON a.GradeId = g.Id
ORDER BY a.Name;

--6 Starting with the above query, add the recorded gender of each of the authors.
SELECT TOP 76 a.name as TopSeventySixWithGender, g.name, gen.name
FROM Author a LEFT JOIN Grade g ON a.GradeId = g.Id
LEFT JOIN Gender gen ON a.GenderId = gen.Id;

--7 What is the total number of words in all poems in the database?
SELECT SUM(p.WordCount) as PoemWordCount
FROM POEM p

--8 Which poem has the fewest characters?
SELECT p.CharCount
FROM Poem p
WHERE p.CharCount = (SELECT MIN(p.CharCount) FROM Poem p);

--9 How many authors are in the third grade?
SELECT COUNT(a.Id) ThirdGradeAuthors
FROM Author a LEFT JOIN Grade g ON a.GradeId = g.Id
WHERE g.Id = 3;

--10 How many authors are in the first, second or third grades?
SELECT COUNT(a.id) AuthorCount, g.name
FROM Author a LEFT JOIN Grade g ON a.GradeId = g.Id
Where g.Id = 1 OR g.Id =2 OR g.Id = 3
GROUP BY g.Name

--11 What is the total number of poems written by fourth graders?
SELECT COUNT(p.id) FourthGradePoemCount
FROM Author a LEFT JOIN Poem p ON a.Id = p.AuthorId
WHERE a.GradeId = 4

--12 How many poems are there per grade?
SELECT COUNT(p.Id) PoemCount, g.name
FROM Poem p LEFT JOIN  Author a ON p.AuthorId = a.Id
LEFT JOIN Grade g on a.GradeId = g.Id
GROUP BY g.Name

--13 How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT COUNT(a.id) AuthorsPerGrade, g.name
FROM Author a LEFT JOIN Grade g ON a.GradeId = g.Id
GROUP BY g.name
ORDER BY g.name

--14 What is the title of the poem that has the most words?
SELECT p.Title
FROM Poem p 
WHERE p.WordCount = (Select MAX(p.WordCount) FROM Poem p);

--15 Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT COUNT(p.Id) as NumOfPoems, a.name
FROM Author a LEFT JOIN Poem p ON p.AuthorId = a.Id
GROUP By a.Id, a.Name
ORDER BY NumOfPoems DESC

--16 How many poems have an emotion of sadness?
SELECT COUNT(p.id) SadPoems
FROM PoemEmotion pe JOIN Emotion e ON pe.EmotionId = e.Id
JOIN Poem p ON p.Id = pe.PoemId
WHERE e.Name = 'Sadness'

--17 How many poems are not associated with any emotion?
SELECT COUNT(p.Id) as NoEmotionPoems
FROM Poem p  LEFT JOIN PoemEmotion pe on pe.PoemId = p.Id
left JOIN Emotion e ON pe.EmotionId = e.Id
GROUP BY e.name
HAVING e.name IS NULL

--18 Which emotion is associated with the least number of poems?
SELECT COUNT(e.name) LeastUsedEmotion, e.name
FROM PoemEmotion pe LEFT JOIN Emotion e ON pe.EmotionId = e.Id
LEFT JOIN Poem p ON pe.PoemId = p.Id
WHERE pe.EmotionId = (SELECT MIN(pe.EmotionId) FROM PoemEmotion pe)
GROUP BY e.Name

--19 Which grade has the largest number of poems with an emotion of joy?
 SELECT COUNT(g.Name) GradeJoyEmotionCount, g.Name
 FROM Poem p LEFT JOIN Author a ON p.AuthorId = a.Id
 LEFt JOIN Grade g ON a.GradeId = g.Id
 LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
 LEFT JOIN Emotion e ON e.Id = pe.EmotionId
 WHERE e.Name = 'Joy' AND g.name = (SELECT MAX(g.name) FROM Grade g)
 GROUP BY g.Name

--20 Which gender has the least number of poems with an emotion of fear?
SELECT COUNT(g.name) GenderFearEmotionCount, g.name
FROM POEM p LEFT JOIN Author a ON p.AuthorId = a.Id
LEFT JOIN Gender g ON g.Id = a.GenderId
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
WHERE e.Name = 'Fear' AND g.name = (SELECT MAX(g.name) FROM Gender g)
GROUP BY g.name 
