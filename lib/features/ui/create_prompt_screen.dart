import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/prompt_bloc.dart';

class CreatePromptScreen extends StatefulWidget {
  const CreatePromptScreen({super.key});

  @override
  State<CreatePromptScreen> createState() => _CreatePromptScreenState();
}

class _CreatePromptScreenState extends State<CreatePromptScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Trigger the initial event to load an image or prepare the state
    context.read<PromptBloc>().add(PromptInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate Images 🚀"),
      ),
      body: BlocConsumer<PromptBloc, PromptState>(
        listener: (context, state) {
          if (state is PromptGeneratingImageErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("An error occurred while generating the image")),
            );
          }
        },
        builder: (context, state) {
          if (state is PromptGeneratingImageLoadState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PromptGeneratingImageErrorState) {
            return const Center(child: Text("Something went wrong"));
          } else if (state is PromptGeneratingImageSuccessState) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(state.unit8list),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Enter your prompt",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: controller,
                        cursorColor: Colors.deepPurple,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                          ),
                          onPressed: () {
                            if (controller.text.isNotEmpty) {
                              context.read<PromptBloc>().add(PromptEnteredEvent(prompt: controller.text));
                            }
                          },
                          icon: const Icon(Icons.image),
                          label: const Text("Generate"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            // Default state if no specific state matches
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Enter a prompt and press 'Generate' to create an image.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextField(
                      controller: controller,
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                        hintText: "Type your prompt here...",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                    ),
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        context.read<PromptBloc>().add(PromptEnteredEvent(prompt: controller.text));
                      }
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("Generate"),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
