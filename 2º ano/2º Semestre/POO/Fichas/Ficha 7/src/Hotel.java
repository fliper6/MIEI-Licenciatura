 public class Hotel {
        // variáveis de instância - substitua o exemplo abaixo pelo seu próprio
        private int id;
        private String nome;
        private String localidade;
        private int estrelas;
        private int nQuartos;
        private double preco;

        /**
         * COnstrutor para objetos da classe Hotel
         */
        public Hotel(){
            // inicializa variáveis de instância
            this.id = 0;
            this.nome = "";
            this.localidade = "";
            this.estrelas = 0;
            this.nQuartos = 0;
            this.preco = 0;
        }
        public Hotel(int id, String nome, String localidade, String categoria, int nq, double preco){
            // inicializa variáveis de instância
            this.id = id;
            this.nome = nome;
            this.localidade = localidade;
            this.estrelas = 0;
            this.nQuartos = 0;
            this.preco = 0;
        }
        public Hotel (Hotel outroHotel){
            this.id = outroHotel.getId();
            this.nome = outroHotel.getNome();
            this.localidade = outroHotel.getLocalidade();
            this.estrelas = outroHotel.getEstrelas();
            this.nQuartos = outroHotel.getNQuartos();
            this.preco = outroHotel.getPreco();
        }

        public int getId(){
            // ponha seu código aqui
            return this.id;
        }
        public String getNome(){
            return this.nome;
        }
        public String getLocalidade(){
            return this.localidade;
        }
        public int getEstrelas(){
            return this.estrelas;
        }
        public int getNQuartos(){
            return this.nQuartos;
        }
        public double getPreco(){
            return this.preco;
        }
        public Hotel clone() {
            return new Hotel(this);
        }

        public boolean equals(Object obj) {
            if(obj==this) return true;
            if(obj==null || obj.getClass() != this.getClass()) return false;
            Hotel h = (Hotel) obj;
            return h.getId() == this.id && h.getNome().equals(this.nome) &&
                    h.getLocalidade().equals(this.localidade) && h.getEstrelas() == this.estrelas
                    && h.getNQuartos() == this.nQuartos && h.getPreco() == this.preco;
        }

        public String toString() {
            StringBuilder sb = new StringBuilder();
            sb.append("ID: ").append(this.id);
            sb.append("Nome: ").append(this.nome);
            sb.append("Localidade: ").append(this.localidade);
            sb.append("Número de Quartos: ").append(this.nQuartos);
            sb.append("Preço por noite: ").append(this.preco);
            return sb.toString();
        }
 }