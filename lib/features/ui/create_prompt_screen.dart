import 'package:flutter/material.dart';

class CreatePromptScreen extends StatefulWidget {
  const CreatePromptScreen({super.key});

  @override
  State<CreatePromptScreen> createState() => _CreatePromptScreenState();
}

class _CreatePromptScreenState extends State<CreatePromptScreen> {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.grey.shade500,
        title: Text("Generate Images"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
                  color: Colors.deepPurpleAccent,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 260,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Enter your prompt",style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold
                    ),),
                     SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        controller: controller,
                        cursorColor: Colors.deepPurple,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepPurple
                            ),
                              borderRadius: BorderRadius.circular(12)
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      height: 48,
                      width: double.maxFinite,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                        ),
                          onPressed: (){},
                          icon: Icon(Icons.generating_tokens),
                          label: Text("Generate")
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
