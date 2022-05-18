message(STATUS "[*] START FETCHING DEPENDENCIES")
include(FetchContent)

message(STATUS "[*] Start fetching DEPENDENCIES")
message(STATUS "[1/3] FETCHING QtGeneratorCMake")
set(QTGENERATORCMAKE_REPOSITORY "https://github.com/OlivierLDff/QtGeneratorCMake.git" CACHE STRING "QtGeneratorCMake repository, can be a local URL")
set(QTGENERATORCMAKE_TAG "master" CACHE STRING "QtGeneratorCMake git tag")

FetchContent_Declare(
  QtGeneratorCMake
  GIT_REPOSITORY ${QTGENERATORCMAKE_REPOSITORY}
  GIT_TAG        ${QTGENERATORCMAKE_TAG}
)
FetchContent_MakeAvailable(QtGeneratorCMake)

message(STATUS "[2/3] FETCHING Qaterial")
FetchContent_Declare(
  Qaterial
  GIT_REPOSITORY https://github.com/ssakone/Qaterial.git
  GIT_TAG        qt6_update # release-1.10.0
)
FetchContent_MakeAvailable(Qaterial)

message(STATUS "[3/3] FETCHING SortFilterProxyModel")
FetchContent_Declare(
  SortFilterProxyModel
  GIT_REPOSITORY https://github.com/ssakone/SortFilterProxyModel.git
  GIT_TAG        3ba9b42 # release-1.10.0
)
FetchContent_MakeAvailable(SortFilterProxyModel)
