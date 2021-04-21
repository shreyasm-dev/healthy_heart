import 'dart:js' as js;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextSpan text(String text) {
  return TextSpan(
    text: text,
  );
}

TextSpan link(String url) {
  return TextSpan(
    text: url,
    recognizer: new TapGestureRecognizer()..onTap = () => js.context.callMethod('open', [url, '_blank']),
    style: TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
  );
}

TextSpan h1(String text) {
  return TextSpan(
    text: '$text\n\n',
    style: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextSpan h2(String text) {
  return TextSpan(
    text: '\n$text\n',
    style: TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
    ),
  );
}

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Flexible(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          h1('Information'),
                          text('Maintaining a healthy heart is important. Heart disease is the leading cause of death in the US, according to the CDC ('),
                          link('https://www.cdc.gov/nchs/fastats/leading-causes-of-death.htm'),
                          text('). To prevent heart disease, the two most important things to do are exercise and eat healthily.\n'),
                          h2('1. Eating Healthily'),
                          h2('2. Exercise'),
                          h2('3. Stress Management'),
                          h2('4. Smoking and Alcohol'),
                          h2('5. Further Reading'),
                          h2('Eating Healthily'),
                          text('Healthy eating can drastically reduce your chances of developing heart disease, according to '),
                          link('https://www.healthline.com/nutrition/healthy-eating-for-beginners'),
                          text('. The same source says that a good diet "can improve all aspects of life, from brain function to physical performance. In fact, food affects all your cells and organs". It also says that whole foods should be consumed often, since they contain more nutrients. Processed foods also contain "empty" calories, which are linked with various heart diseases. Foods that you should avoid most of the time are sugar-based foods, trans and sat fats, refined carbohydrates, vegetable oils, and more. On the other hand, some very healthy foods are whole eggs, whole starchy foods, nuts/seeds, dairy, beans, herbs/spices, and many others. '),
                          link('https://www.mayoclinic.org/diseases-conditions/heart-disease/in-depth/heart-healthy-diet/art-20047702'),
                          text(' says that, to prevent heart disease, you should eat more vegetables and fruits, eat whole grains, limit unhealthy fats, reduce sodium intake, etc. '),
                          link('https://www.webmd.com/food-recipes/features/cholesterol-food'),
                          text(' says that the AHA (American Heart Association) recommends under 300mg of cholesterol every day. While trying to limit cholesterol intake, it\'s important to also look at saturated and trans fat intake, as they can have a big impact on cholesterol levels. It also says that in studies where volunteers were given eggs, "researchers found that lowering the amount of dietary cholesterol by 100 milligrams a day resulted in only a 1% reduction in blood cholesterol levels. Replacing saturated fat with unsaturated fat had a much more beneficial effect on cholesterol".\n'),
                          h2('Exercise'),
                          text('A healthy amount of exercise can improve heart health, prevent heart disease, and even improve life expectancy, according to '),
                          link('https://www.livescience.com/36723-exercise-life-expectancy-overweight-obese.html'),
                          text('. A minimum of 30 minutes a day is recommended for most people, but the exact amount depends on your health, height, and weight. Exercise is very important to preventing heart disease since, according to '),
                          link('https://wa.kaiserpermanente.org/healthAndWellness?item=%2Fcommon%2FhealthAndWellness%2Fconditions%2FheartDisease%2FexerciseBenefit.html'),
                          text(', exercise improves the efficiency of the heart and allows it to better pump blood throughout the body. It allows the heart to pump more blood with every beat, so the heart can beat slower.\n'),
                          h2('Stress Management'),
                          link('https://www.heart.org/en/healthy-living/healthy-lifestyle/stress-management/stress-and-heart-health'),
                          text(' says that managing stress is "a good idea for your overall health", and that "researchers are currently studying whether managing stress is effective for heart disease". Stress can increase blood pressure and can increase risk of heart problems. To keep stress levels down, '),
                          link('https://www.webmd.com/heart-disease/features/reduce-stress-heart-health'),
                          text(' quotes that focusing on "your physical, emotional, and psychological well-being helps keep it under control". It elaborates by saying that, to keep stress at a minimum, you can eat a healthy diet, exercise on most days, get good amounts of sleep, stay away from alcohol and drugs, keep a reasonably manageable schedule, take time to relax, etc. You can also do yoga or meditate, since they help you feel relaxed, which reduces stress and anxiety.\n'),
                          h2('Smoking and Alcohol'),
                          link('https://www.bhf.org.uk/informationsupport/heart-matters-magazine/medical/effects-of-alcohol-on-your-heart'),
                          text(' says that alcohol can increase the risk of cardiovascular disease (CVD), which in turn increase your risk of a heart attack or stroke. In addition to various heart diseases, drinking alcohol can also cause other non-heart related diseases. Smoking can also seriously affect your heart. '),
                          link('https://www.nhlbi.nih.gov/health-topics/smoking-and-your-heart'),
                          text(' says that "smoking causes about 1 in every 5 deaths in the United States each year. It\'s the main preventable cause of death and illness in the United States". It also says that the chemicals in tobacco harm blood cells, and can damage the function of the heart and change the structure of blood vessels. In addition, it says "Ischemic heart disease occurs if plaque builds up in the arteries that supply blood to the heart, called coronary arteries. Over time, heart disease can lead to chest pain, heart attack, heart failure, arrhythmias, or even death".\n'),
                          h2('Further Reading'),
                          text('"Eating Right for Your Heart" - '),
                          link('https://www.ucsfhealth.org/education/eating-right-for-your-heart'),
                          text('\n"Healthy Living" - '),
                          link('https://www.heart.org/en/healthy-living'),
                          text('\n"Keep Your Heart Healthy" - '),
                          link('https://health.gov/myhealthfinder/topics/health-conditions/heart-health/keep-your-heart-healthy'),
                        ],
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
