# modules/apps/gemini.nix
{ ... }:
{
  flake.modules.homeManager.gemini-cli =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gemini-cli
        antigravity
      ];

      # Optional: set environment variables if you use Vertex / GCP project IDs
      # home.sessionVariables = {
      #   GOOGLE_CLOUD_PROJECT = "your-gcp-project-id";
      # };
    };
}
