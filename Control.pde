class Control {
  ArrayList<Element> elements;
  
  Control() {
     elements = new ArrayList<Element>();
  }
  
  void add(Element e) {
    elements.add(e);
  }
  
  HashMap<String, Element> getSettings() {
    HashMap<String, Element> out = new HashMap<String, Element>();
    for (int e = 0; e < elements.size(); e++) {
      out.put(elements.get(e).getName(), elements.get(e));
    }
    return out;
  }
  
  void update() {
    for (Element e : elements) {
      e.update();
    }
  }
  
  void draw() {
    fill(173, 216, 230);
    rect(600, 0, 600, 600);
    for (Element e : elements) {
      e.draw();
    }
    update();
  }
  
  Element getElem(int i) {
    return elements.get(i);
  }
}
