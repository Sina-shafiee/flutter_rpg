import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rpg/models/character.dart';
import 'package:rpg/models/vocation.dart';
import 'package:rpg/screens/create/vocation_card.dart';
import 'package:rpg/services/character_store.dart';
import 'package:rpg/shared/styled_button.dart';
import 'package:rpg/shared/styled_text.dart';
import 'package:rpg/theme.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  CreateScreenState createState() => CreateScreenState();
}

class CreateScreenState extends State<CreateScreen> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _sloganController = TextEditingController();

  Vocation activeVocation = Vocation.junkie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(title: const StyledTitle("Character Creation"));
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Main Title
            _buildTitle(
              Icons.code,
              "Welcome new player",
              "Create a name & slogan for your character",
            ),

            _buildVerticalSpacer(),

            // inputs
            _buildInputs(),

            _buildVerticalSpacer(),

            // vocations title
            _buildTitle(
              Icons.code,
              "Choose a vocation.",
              "This determains your skills",
            ),

            _buildVerticalSpacer(),

            // vocation cards
            _buildVocations(),

            _buildVerticalSpacer(),

            // bye title
            _buildTitle(
              Icons.code,
              "Good luck boy.",
              "And Enjoy the journey...",
            ),

            _buildVerticalSpacer(),

            // submit button
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputs() {
    return Column(
      children: <Widget>[
        TextField(
          controller: _nameTextController,
          cursorColor: AppColors.textColor,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.person_2),
            label: StyledText("Character Name"),
          ),
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _sloganController,
          cursorColor: AppColors.textColor,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.chat),
            label: StyledText("Character Slogan"),
          ),

          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: StyledButton(
        onPressed: _handleSubmit,
        child: const StyledHeading("Create Character"),
      ),
    );
  }

  Widget _buildTitle(IconData icon, String heading, String description) {
    return Column(
      children: <Widget>[
        Center(child: Icon(icon, color: AppColors.textColor)),
        Center(child: StyledHeading(heading)),
        Center(child: StyledText(description)),
      ],
    );
  }

  Widget _buildVerticalSpacer({double spacing = 30}) {
    return SizedBox(height: spacing);
  }

  Widget _buildVocations() {
    return Column(
      children: <Widget>[
        VocationCard(
          vocation: Vocation.junkie,
          onTap: _onVocationCardTap,
          isActive: activeVocation == Vocation.junkie,
        ),
        VocationCard(
          vocation: Vocation.ninja,
          onTap: _onVocationCardTap,
          isActive: activeVocation == Vocation.ninja,
        ),
        VocationCard(
          vocation: Vocation.raider,
          onTap: _onVocationCardTap,
          isActive: activeVocation == Vocation.raider,
        ),
        VocationCard(
          vocation: Vocation.wizard,
          onTap: _onVocationCardTap,
          isActive: activeVocation == Vocation.wizard,
        ),
      ],
    );
  }

  void _handleSubmit() {
    final String nameValue = _nameTextController.text.trim();
    final String sloganValue = _sloganController.text.trim();

    if (nameValue.isEmpty) {
      _showDialog(
        "Missing Character Name",
        "Every great RPG character needs a great name...",
      );
      return;
    }
    if (sloganValue.isEmpty) {
      _showDialog(
        "Missing Character Slogan",
        "Remember to add a catchy slogan...",
      );
      return;
    }
    Provider.of<CharacterStore>(context, listen: false).addCharacter(
      Character(
        id: uuid.v4(),
        name: nameValue,
        slogan: sloganValue,
        vocation: activeVocation,
      ),
    );
    Navigator.pop(context);
  }

  void _onVocationCardTap(Vocation vocation) {
    setState(() {
      activeVocation = vocation;
    });
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: StyledHeading(title),
          content: StyledText(content),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            StyledButton(
              child: const StyledHeading("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
