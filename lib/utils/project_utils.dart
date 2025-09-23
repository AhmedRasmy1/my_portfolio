class ProjectUtils {
  final String title;
  final String image;
  final String subtitle;
  final String? androidLink;
  final String? iosLink;
  final String? webLink;
  final String githubLink;

  ProjectUtils({
    required this.title,
    required this.image,
    required this.subtitle,
    this.androidLink,
    this.iosLink,
    this.webLink,
    required this.githubLink,
  });
}

List<ProjectUtils> projectList = [
  ProjectUtils(
    title: "ServiceX",
    image: "assets/images/servicex_image.png",
    subtitle:
        " Is a platform designed to simplify home repair services for Egyptian citizens. We connect users with skilled and reliable technicians for various household issues, such as electricity, plumbing, and more",
    githubLink: "https://github.com/example/project1",
  ),
  ProjectUtils(
    title: "Elmohandes",
    image: "assets/images/elmohamndes_image.png",
    subtitle:
        "Developed Elmohandes for managing invoices and sales on both mobile and desktop platforms",
    githubLink: "https://github.com/example/project1",
  ),
  ProjectUtils(
    title: "Flowery",
    image: "assets/images/flowery_image.png",
    subtitle:
        "Developed an e-commerce application for browsing and purchasing flowers.",
    githubLink: "https://github.com/example/project1",
  ),
];
