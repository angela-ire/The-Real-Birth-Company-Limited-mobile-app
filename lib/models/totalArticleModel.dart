class Totalarticlemodel {
  int reads;
  int revisits;
  int total;

  Totalarticlemodel({required this.reads, required this.revisits, required this.total});

  static Totalarticlemodel fromJson(Map<String, dynamic>? json) => Totalarticlemodel(reads: json?["reads"], 
  revisits: json?["revisits"], total: json?["total"]);

  Map<String, dynamic> toJson() =>{
    'reads': reads,
    'revisits': revisits,
    'total': total
  };

}