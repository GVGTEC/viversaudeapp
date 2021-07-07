const app = {}

app.contas_pag = {}
app.contas_pag.mais = function(){
  $("#conteudoContainer").append($("#conteudoContainerTemplate").html());
}