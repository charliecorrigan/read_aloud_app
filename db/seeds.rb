School.destroy_all
Classroom.destroy_all
User.destroy_all

STAFF_NAMES = [["Minerva", "McGonagall", "mmcgonagall"], ["Rubeus", "Hagrid", "rhagrid"], ["Sybill", "Trelawney", "strelawney"]]
VOLUNTEER_NAMES = [["Harry", "Potter", "hpotter"], ["Hermione", "Granger", "hgranger"], ["Ronald", "Weasley", "rweasely"], ["Luna", "Lovegood", "llovegood"]]
SCHOOL_NAMES = [["Hogwarts School of Witchcraft and Wizardry", "Highlands, Scotland"], ["Beauxbatons Academy of Magic", "Pyrenees, France"], ["Durmstrang Institute", "Northern Scandinavia"]]
CLASSROOM_INFO = [["Ms. Umbridge", "ECE", 18], ["Professor Snape", "Kindergarten", 24], ["Remus Lupin", "ECE", 19]]

admin = User.create(first_name: "Albus",
                      last_name: "Dumbledore",
                      username: "hogwarts4life",
                      password: "lemondrop",
                      role: 2,
                      language: 0)

STAFF_NAMES.each do |name|
  User.create!(first_name: name[0],
              last_name: name[1],
              username: name[2],
              password: "password",
              role: 1,
              language: 0)
end

VOLUNTEER_NAMES.each do |name|
  User.create!(first_name: name[0],
              last_name: name[1],
              username: name[2],
              password: "password",
              role: 0,
              language: 0)
end

SCHOOL_NAMES.each do |name|
  school = School.create!(name: name[0], address: name[1])
  CLASSROOM_INFO.each do |value|
    classroom = school.classrooms.create(teacher_name: value[0], grade_level: value[1], number_of_students_enrolled: value[2])
    UserClassroom.create(user_id: User.find_by(first_name: STAFF_NAMES.sample).id, classroom_id: classroom.id)
  end
end
