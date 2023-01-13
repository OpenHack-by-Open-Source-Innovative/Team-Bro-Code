// import 'dart:convert';

// import 'package:http/http.dart' as http;

// void main() {

//   Future<void> postToLocalHost() async {
//     String url = "http://127.0.0.1";
//     String longText = "The three-paragraph essay is the simplest form where each paragraph is dedicated to a section. There are those who say that an essay should consist of at least three body paragraphs, but it’s okay if you include more paragraphs in this section. This begs the question: how many paragraphs comprise a long essay?In academic works, your paragraphs are likely to be a bit longer than most of what you see in blog posts and other articles. An academic paragraph can contain between 100 to 200 words, which translates to about five and ten paragraphs in a 1000 word essay, answering how long are college essays supposed to be.The points to be coveredThe number of points that you need to cover in your essay should determine the number of paragraphs that you are going to include in your essay. Each paragraph revolves around a single idea that connects to the central idea of your essay. In the planning of your essay, you will have to consider and research on all the major elements that are required in the body text. You can assume that each paragraph will take each one of these ideas. Availability of information needed to cover each area will require you to have more paragraphs. That is the answer to how long should college essays be?The content is crucial than the number of paragraphsWhether you are writing a long or a short essay, the content of your essay is of high importance. It doesn’t matter how long are college essays going to be. The evaluation of your essay hinges on the information that you present, not the number of paragraphs in your paper. At times, you will be given an essay stricture and a guideline on the length of each part.In other instances, you will receive a topic to which you will write your perspective about it. This is good freedom, but it can be difficult at times. A song some research will give you options on the best perspectives to use. It will also give you information that supports or goes against your perspective. If you want to make a string argument, you have to look at both the supporting and contradicting information about your topic.If you want to avoid being stuck in one discussion, you have to decide on the length of your essay. This assists in coming up with a conclusion, and you can take some time on that specific point. Keep in mind the purpose of each paragraph. They structure your information into subtopics, thereby making your work easier to read. With good planning, you will be able to decide the number of paragraphs that will go into your essay.Answering the what how and why in a long essay.A typical long essay will consist of diverse kin fog information. Even short essays contain the introduction of the main argument, data analysis, raising counter arguments and conclusion. For introduction and conclusion, they have a definite place, as opposed to other parts. For instance, a counter argument can appear in a specific paragraph, as a stand-alone section, as a part of the beginning or before the ending. Background information in most cases appears at the beginning of your essay. This fall s between the introduction and the first section of the analysis, although it might also come close the beginning of a particular section to which it is relevant.When answering probable questions from the audience, as well as how long should college essays be, you have to think of every essay sections. The first question they ask is:What?This is the first question you ought to anticipate from your audience. You must show the evidence that proves the phenomenon described in your thesis is true. You must examine your evidence to be able to answer this question. In other words, you are demonstrating the truth of your claim. This question comes early in your essay and most cases, directly after the introduction. However, it should not take up more than a third of your entire essay to ensure balance.How?The reader will want to ascertain the truth of your claims in all classes. You have to show how your thesis defends itself from the counter-arguments. The reader also wants to see how the introduction of new material, as well as new ways of looking at the evidence, influence the claims that you are making. This section comes after what and can make its argument complicated severally depending on its length. The counter-argument may appear anywhere in the essay.Why?The audience wants to know why your interpretation of a phenomenon matters to anyone besides you. This is where you address the larger implication of your thesis by allowing the reader to understand your essay in the larger context. This section explains the significance of your essay. The full answer to this question will be found the end of your essay. Its omission makes your essay unfinished, or worse still, pointless.";
//     final response = await http.post(Uri.parse("http://127.0.0.1/summarize?text=$longText&limit=500"));
//     final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
//     print(decodedResponse["text"]);
//   }

//   postToLocalHost();
// }


// import 'dart:convert';
// import 'package:http/http.dart' as http;

// void main() {
//   Future<void> postImageToLocalHost() async {
//     String url = "http://127.0.0.1:5000/extract_text_from_img";
//     var request = http.MultipartRequest('POST', Uri.parse(url));
//     var picture = await http.MultipartFile.fromPath("file", "text_msg_2.jpeg");
//     request.files.add(picture);
    
//     // var response = await request.send();
//     // print(response.toString());
//     // if(response.statusCode == 200) {
//     //   print("Image uploaded successfully");
//     // } else{
//     //   print("Image upload failed");
//     // }
//     // // print(response.stream.bytesToString());
//     // var stringResponse = (await response.stream.bytesToString());
//     // print(stringResponse);


//     var streamedResponse = await request.send();
//     var response = await http.Response.fromStream(streamedResponse);
//     var decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
//     print(decodedResponse["extracted"]);
//   }

//   postImageToLocalHost();
// }


import 'dart:convert';

import 'package:http/http.dart' as http;

void main() {

  Future<void> postMessageToChatBotLocalHost() async {
    String message = "hello";
    final response = await http.post(Uri.parse("http://127.0.0.1/response?msg=$message"));
    final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
    print(decodedResponse["text"]);
  }

  postMessageToChatBotLocalHost();
}